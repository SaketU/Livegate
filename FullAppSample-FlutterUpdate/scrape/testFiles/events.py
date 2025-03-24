import requests
import datetime

# Your API key from https://api-sports.io/
API_KEY = "bc8dd03b99663e6aaafaae50503aee04"  # Replace with your actual API key
BASE_URL = "https://api-sports.io"

# Headers for API request
HEADERS = {
    "x-apisports-key": API_KEY
}

def get_sports():
    """Fetch all available sports from API-SPORTS"""
    url = f"{BASE_URL}/sports"
    response = requests.get(url, headers=HEADERS)
    
    if response.status_code == 200:
        return response.json().get("response", [])
    else:
        print("Error fetching sports:", response.json())
        return []

def get_events(sport):
    """Fetch events for a given sport in the next 2 weeks"""
    today = datetime.date.today()
    two_weeks_later = today + datetime.timedelta(days=14)
    
    url = f"{BASE_URL}/fixtures"
    params = {
        "dateFrom": today.strftime("%Y-%m-%d"),
        "dateTo": two_weeks_later.strftime("%Y-%m-%d"),
        "sport": sport  # Filtering by sport
    }

    response = requests.get(url, headers=HEADERS, params=params)

    if response.status_code == 200:
        return response.json().get("response", [])
    else:
        print(f"Error fetching events for {sport}: {response.json()}")
        return []

def main():
    sports = get_sports()
    
    if not sports:
        print("No sports found!")
        return
    
    print(f"Fetching events for {len(sports)} sports...")
    
    all_events = []

    for sport in sports:
        sport_name = sport.get("name")
        print(f"Fetching events for {sport_name}...")
        
        events = get_events(sport_name)
        
        for event in events:
            all_events.append({
                "Sport": sport_name,
                "Date": event.get("date"),
                "Event": event.get("name", "Unknown Event"),
                "League": event.get("league", {}).get("name", "Unknown League"),
                "Teams": f"{event.get('teams', {}).get('home', {}).get('name', 'N/A')} vs {event.get('teams', {}).get('away', {}).get('name', 'N/A')}",
                "Venue": event.get("venue", {}).get("name", "Unknown Venue"),
            })
    
    if all_events:
        print("\nUpcoming Sports Events in the Next Two Weeks:")
        for event in all_events:
            print(f"{event['Date']} - {event['Sport']} - {event['League']} - {event['Teams']} at {event['Venue']}")
    else:
        print("No events found for the next two weeks.")

if __name__ == "__main__":
    main()
