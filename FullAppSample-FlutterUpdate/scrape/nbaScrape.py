from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
import time
import json
import os
print("Current working directory:", os.getcwd())

# Set up WebDriver
service = Service(executable_path="\\Users\\saket\\livegatebackup\\FullAppSample-FlutterUpdate\\scrape\\chromedriver.exe")
driver = webdriver.Chrome(service=service)


driver.get("https://www.nba.com/games")
time.sleep(5)  # Allow page to load

team_names = driver.find_elements(By.CLASS_NAME, "MatchupCardTeamName_teamName__9YaBA")
team_names_text = [team.text for team in team_names]

team_logos = driver.find_elements(By.CLASS_NAME, "TeamLogo_block__rSWmO")

team_logos_src = [logo.find_element(By.TAG_NAME, "img").get_attribute("src") for logo in team_logos]

games = []
for i in range(0, len(team_names_text), 2):
    if i + 1 < len(team_names_text):  # Make sure we have both teams
        games.append({
            "team1": team_names_text[i],
            "team2": team_names_text[i + 1],
            "team1_logo": team_logos_src[i],
            "team2_logo": team_logos_src[i + 1]
        })

# Create the directory if it doesn't exist
os.makedirs("\\Users\\saket\\livegatebackup\\FullAppSample-FlutterUpdate\\scrape\\local_db", exist_ok=True)

# Now write the file
with open("\\Users\\saket\\livegatebackup\\FullAppSample-FlutterUpdate\\scrape\\local_db\\nba_games.json", "w", encoding="utf-8") as file:
    json.dump(games, file, indent=4)

driver.quit()

print("Scraping complete. Results saved in nba_games_today.json")
