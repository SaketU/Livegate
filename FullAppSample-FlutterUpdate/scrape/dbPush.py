import json
from pymongo import MongoClient
from datetime import datetime
import os


MONGO_URI = "mongodb+srv://saketupperla7:wYT7f5alEG4YYJiI@sports.8zp6u.mongodb.net/?retryWrites=true&w=majority&appName=sports"

client = MongoClient(MONGO_URI)

db = client["leagues"]
collection = db["NBA"]


json_file_path = "\\Users\\saket\\livegatebackup\\FullAppSample-FlutterUpdate\\scrape\\local_db\\nba_games.json"

# Create the directory if it doesn't exist
os.makedirs("\\Users\\saket\\livegatebackup\\FullAppSample-FlutterUpdate\\scrape\\local_db", exist_ok=True)

with open(json_file_path, "r") as file:
    games = json.load(file)

for game in games:
    game_data = {
        "home_team": game["team1"],
        "away_team": game["team2"],
        "home_team_logo": game["team1_logo"],
        "away_team_logo": game["team2_logo"],
        # "game_time": datetime.utcnow(), 
        "venue": "TBD", 
        "status": "Scheduled"
    }
    collection.update_one(
        {"home_team": game["team1"], "away_team": game["team2"]},
        {"$set": game_data},
        upsert=True
    )

print(f"Inserted {len(games)} games into the NBA collection.")

client.close()
