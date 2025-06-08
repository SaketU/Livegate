from fastapi import FastAPI, WebSocket, WebSocketDisconnect
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
            "timestamp": datetime.utcnow().isoformat()
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
        messages.reverse()  # Keep in chronological order
        return messages

manager = ConnectionManager()

@app.websocket("/ws/{room_id}/{user_name}")
async def chat_endpoint(websocket: WebSocket, room_id: str, user_name: str):
    await manager.connect(websocket, room_id, user_name)
    try:
        while True:
            message = await websocket.receive_text()
            await manager.broadcast_message(message, room_id, user_name)
    except WebSocketDisconnect:
        await manager.disconnect(websocket, room_id, user_name)
        await manager.broadcast_message(f"{user_name} has left the chat", room_id, "System")

# Get online users in a room
@app.get("/rooms/{room_id}/online")
async def get_online_users(room_id: str):
    online_users = await db.online_users.find({"room_id": room_id}, {"_id": 0, "user_name": 1}).to_list(None)
    return {"online_users": [user["user_name"] for user in online_users]}
