import json
from pymongo import MongoClient
from datetime import datetime, timedelta
import os
import pytz


MONGO_URI = "mongodb+srv://saketupperla7:wYT7f5alEG4YYJiI@sports.8zp6u.mongodb.net/?retryWrites=true&w=majority&appName=sports"

client = MongoClient(MONGO_URI)

db = client["leagues"]
collection = db["NBA"]


json_file_path = "\\Users\\saket\\livegatebackup\\FullAppSample-FlutterUpdate\\scrape\\local_db\\nba_games.json"

# Create the directory if it doesn't exist
os.makedirs("\\Users\\saket\\livegatebackup\\FullAppSample-FlutterUpdate\\scrape\\local_db", exist_ok=True)

with open(json_file_path, "r") as file:
    games = json.load(file)

def get_game_status(scheduled_time):
    current_time = datetime.now(pytz.UTC)
    game_end_time = scheduled_time + timedelta(hours=3)  # Assuming average game duration of 3 hours
    
    if current_time < scheduled_time:
        return "Scheduled", False
    elif scheduled_time <= current_time <= game_end_time:
        return "Live now", True
    else:
        return "Finished", False

def insert_games(games):
    # First, remove all existing games
    collection.delete_many({})
    
    for game in games:
        try:
            # Create a scheduled time for today at a specific hour
            # This is temporary - in production you'd get this from the NBA API
            current_time = datetime.now(pytz.UTC)
            
            # Set game times throughout the day
            game_hour = (games.index(game) * 3) % 24  # Spread games 3 hours apart
            scheduled_time = current_time.replace(
                hour=game_hour,
                minute=0,
                second=0,
                microsecond=0
            )
            
            # If the scheduled time is in the past, move it to tomorrow
            if scheduled_time < current_time:
                scheduled_time = scheduled_time + timedelta(days=1)
            
            # Get game status and live flag
            status, is_live = get_game_status(scheduled_time)
            
            game_data = {
                'home_team': game['team1'],
                'away_team': game['team2'],
                'home_team_logo': game['team1_logo'],
                'away_team_logo': game['team2_logo'],
                'scheduled_time': scheduled_time.isoformat(),  # Store as ISO format string
                'status': status,
                'is_live': is_live,
                'league': 'NBA',
                'sport': 'assets/basketball-icon.svg',
                'people': '1.2k',
                'remain': 'Chat'
            }
            
            # Insert into MongoDB
            collection.insert_one(game_data)
            print(f"Inserted game: {game['team1']} vs {game['team2']} (Status: {status}, Time: {scheduled_time})")
        except Exception as e:
            print(f"Error inserting game: {str(e)}")

insert_games(games)

client.close()
print("Database update complete")
