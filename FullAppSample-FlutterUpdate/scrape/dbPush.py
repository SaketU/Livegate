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

def insert_games(games):
    for game in games:
        try:
            # Convert scheduled time string to Date object
            scheduled_time = datetime.strptime(game['scheduled_time'], '%Y-%m-%d %H:%M:%S')
            
            game_data = {
                'home_team': game['home_team'],
                'away_team': game['away_team'],
                'home_team_logo': game['home_team_logo'],
                'away_team_logo': game['away_team_logo'],
                'venue': game['venue'],
                'status': 'Scheduled',
                'scheduled_time': scheduled_time
            }
            
            # Insert into MongoDB
            collection.insert_one(game_data)
            print(f"Inserted game: {game['home_team']} vs {game['away_team']}")
        except Exception as e:
            print(f"Error inserting game: {str(e)}")

insert_games(games)

client.close()
