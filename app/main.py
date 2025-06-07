from fastapi import FastAPI, WebSocket, WebSocketDisconnect, HTTPException
from motor.motor_asyncio import AsyncIOMotorClient
from typing import Dict, List
import json
from datetime import datetime

app = FastAPI()

# MongoDB connection
MONGO_URL = "mongodb://localhost:27017"
mongo_client = AsyncIOMotorClient(MONGO_URL)
db = mongo_client.chat_db  # Database

class ConnectionManager:
    def __init__(self):
        self.rooms: Dict[str, List[WebSocket]] = {}

    async def connect(self, websocket: WebSocket, room_id: str, user_name: str):
        await websocket.accept()
        if room_id not in self.rooms:
            self.rooms[room_id] = []
        self.rooms[room_id].append(websocket)

        # Mark user as online in MongoDB
        await db.online_users.update_one(
            {"room_id": room_id, "user_name": user_name},
            {"$set": {"room_id": room_id, "user_name": user_name, "last_active": datetime.utcnow()}},
            upsert=True
        )

        # Load message history from MongoDB
        messages = await self.get_message_history(room_id)
        for message in messages:
            await websocket.send_text(json.dumps(message))

    async def disconnect(self, websocket: WebSocket, room_id: str, user_name: str):
        if room_id in self.rooms and websocket in self.rooms[room_id]:
            self.rooms[room_id].remove(websocket)

        # Remove user from the online list in MongoDB
        await db.online_users.delete_one({"room_id": room_id, "user_name": user_name})

        if room_id in self.rooms and not self.rooms[room_id]:
            del self.rooms[room_id]

    async def broadcast_message(self, message: str, room_id: str, sender: str):
        message_doc = {
            "message": message,
            "sender": sender,
            "room_id": room_id,
            "timestamp": datetime.utcnow().isoformat(),
            "profile_image": "",  # Store sender's profile image URL
            "reactions": {},      # Store reactions as {emoji: count}
            "reply_to": None,    # Store ID of message being replied to
            "is_deleted": False  # Track if message was deleted
        }

        # Store message in MongoDB
        await db.messages.insert_one(message_doc)

        # Broadcast message to connected clients
        if room_id in self.rooms:
            for connection in self.rooms[room_id]:
                try:
                    await connection.send_text(json.dumps(message_doc))
                except Exception:
                    await self.disconnect(connection, room_id, sender)

    async def get_message_history(self, room_id: str, limit: int = 50):
        # Retrieve the last `limit` messages from MongoDB
        cursor = db.messages.find({"room_id": room_id}).sort("timestamp", -1).limit(limit)
        messages = await cursor.to_list(length=limit)
        
        # For each message, if it's a reply, fetch the original message details
        for message in messages:
            if message.get("reply_to"):
                original_message = await db.messages.find_one({"_id": message["reply_to"]})
                if original_message:
                    message["reply_details"] = {
                        "original_message": original_message["message"],
                        "original_sender": original_message["sender"]
                    }
            
            # If message is deleted, replace content with placeholder
            if message.get("is_deleted", False):
                message["message"] = "This message was deleted"
        
        messages.reverse()  # Keep in chronological order
        return messages

manager = ConnectionManager()

@app.websocket("/ws/{room_id}/{user_name}")
async def websocket_endpoint(websocket: WebSocket, room_id: str, user_name: str):
    await manager.connect(websocket, room_id, user_name)
    try:
        while True:
            data = await websocket.receive_text()
            event = json.loads(data)
            
            if event["type"] == "message":
                await manager.broadcast_message(event["message"], room_id, user_name)
            
            elif event["type"] == "reaction":
                message_id = event["message_id"]
                reaction = event["reaction"]
                message = await db.messages.find_one({"_id": message_id})
                
                if message:
                    reactions = message.get("reactions", {})
                    if reaction not in reactions:
                        reactions[reaction] = []
                    
                    if user_name not in reactions[reaction]:
                        reactions[reaction].append(user_name)
                        await db.messages.update_one(
                            {"_id": message_id},
                            {"$set": {"reactions": reactions}}
                        )
                        
                        # Broadcast reaction update
                        reaction_update = {
                            "type": "reaction_update",
                            "message_id": message_id,
                            "reactions": reactions
                        }
                        if room_id in manager.rooms:
                            for connection in manager.rooms[room_id]:
                                await connection.send_text(json.dumps(reaction_update))
            
            elif event["type"] == "delete":
                message_id = event["message_id"]
                message = await db.messages.find_one({"_id": message_id})
                
                if message and message["sender"] == user_name:
                    await db.messages.update_one(
                        {"_id": message_id},
                        {"$set": {"is_deleted": True}}
                    )
                    
                    # Broadcast deletion
                    delete_update = {
                        "type": "message_deleted",
                        "message_id": message_id
                    }
                    if room_id in manager.rooms:
                        for connection in manager.rooms[room_id]:
                            await connection.send_text(json.dumps(delete_update))
            
    except WebSocketDisconnect:
        await manager.disconnect(websocket, room_id, user_name)

# Get online users in a room
@app.get("/rooms/{room_id}/online")
async def get_online_users(room_id: str):
    online_users = await db.online_users.find({"room_id": room_id}, {"_id": 0, "user_name": 1}).to_list(None)
    return {"online_users": [user["user_name"] for user in online_users]}

@app.post("/message/{message_id}/react")
async def add_reaction(message_id: str, reaction: str, user_name: str):
    message = await db.messages.find_one({"_id": message_id})
    if not message:
        raise HTTPException(status_code=404, detail="Message not found")
    
    reactions = message.get("reactions", {})
    if reaction not in reactions:
        reactions[reaction] = []
    
    # Add user to reaction if not already reacted
    if user_name not in reactions[reaction]:
        reactions[reaction].append(user_name)
        await db.messages.update_one(
            {"_id": message_id},
            {"$set": {"reactions": reactions}}
        )
    return {"success": True}

@app.post("/message/{message_id}/reply")
async def add_reply(message_id: str, reply_message: str, sender: str, room_id: str):
    # First check if original message exists
    original_message = await db.messages.find_one({"_id": message_id})
    if not original_message:
        raise HTTPException(status_code=404, detail="Original message not found")
    
    # Create new message with reply reference
    message_doc = {
        "message": reply_message,
        "sender": sender,
        "room_id": room_id,
        "timestamp": datetime.utcnow().isoformat(),
        "profile_image": "",
        "reactions": {},
        "reply_to": message_id,
        "is_deleted": False
    }
    
    result = await db.messages.insert_one(message_doc)
    return {"success": True, "message_id": str(result.inserted_id)}

@app.delete("/message/{message_id}")
async def delete_message(message_id: str, user_name: str):
    message = await db.messages.find_one({"_id": message_id})
    if not message:
        raise HTTPException(status_code=404, detail="Message not found")
    
    # Only allow sender to delete their own message
    if message["sender"] != user_name:
        raise HTTPException(status_code=403, detail="Not authorized to delete this message")
    
    # Soft delete - mark as deleted instead of removing
    await db.messages.update_one(
        {"_id": message_id},
        {"$set": {"is_deleted": True}}
    )
    return {"success": True}

@app.put("/user/{user_name}/profile-image")
async def update_profile_image(user_name: str, profile_image_url: str):
    # Update user's profile image URL
    await db.users.update_one(
        {"user_name": user_name},
        {"$set": {"profile_image": profile_image_url}},
        upsert=True
    )
    
    # Update profile image in all messages by this user
    await db.messages.update_many(
        {"sender": user_name},
        {"$set": {"profile_image": profile_image_url}}
    )
    return {"success": True}
