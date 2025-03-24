import requests

url = "https://api.sportradar.com/nba/trial/v8/en/games/2024/REG/schedule.json?api_key=5ugG3MZv0Cbdeyh4FA5DLHqyXpa5pyywBkNJvyVC"

headers = {"accept": "application/json"}

response = requests.get(url, headers=headers)

print(response.text)