import 'package:flutter/cupertino.dart';

class Rooms {
  String League;
  String Team1;
  String Team2;
  String Logo1;
  String Logo2;
  String Sport;
  String People;
  String Remain;
  String state;
  IconData icon;
  String gameId;
  DateTime? scheduled_time;
  String team1_abbr;
  String team2_abbr;

  static final Map<String, String> nbaTeams = {
    "Celtics": "BOS",
    "Nets": "BKN",
    "Knicks": "NYK",
    "76ers": "PHI",
    "Raptors": "TOR",
    "Bulls": "CHI",
    "Cavaliers": "CLE",
    "Pistons": "DET",
    "Pacers": "IND",
    "Bucks": "MIL",
    "Hawks": "ATL",
    "Hornets": "CHA",
    "Heat": "MIA",
    "Magic": "ORL",
    "Wizards": "WAS",
    "Nuggets": "DEN",
    "Timberwolves": "MIN",
    "Thunder": "OKC",
    "Trail Blazers": "POR",
    "Jazz": "UTA",
    "Warriors": "GSW",
    "Clippers": "LAC",
    "Lakers": "LAL",
    "Suns": "PHX",
    "Kings": "SAC",
    "Mavericks": "DAL",
    "Rockets": "HOU",
    "Grizzlies": "MEM",
    "Pelicans": "NOP",
    "Spurs": "SAS",
  };

  Rooms({
    required this.League,
    required this.Team1,
    required this.Team2,
    required this.Logo1,
    required this.Logo2,
    required this.Sport,
    required this.People,
    required this.Remain,
    required this.state,
    required this.icon,
    required this.gameId,
    this.scheduled_time,
    required this.team1_abbr,
    required this.team2_abbr,
  });

  // Helper method to get sport icon based on league
  static String getSportIconForLeague(String league) {
    switch (league.toUpperCase()) {
      case 'NBA':
        return 'assets/sports/basketball.svg';
      case 'NCAAB':
        return 'assets/sports/dunk.svg';
      case 'NFL':
        return 'assets/sports/football.svg';
      case 'NCAAF':
        return 'assets/sports/football_run.svg';
      case 'MLB':
        return 'assets/sports/baseball.svg';
      case 'COLLEGE BASEBALL':
        return 'assets/sports/bat.svg';
      case 'NHL':
        return 'assets/sports/hockey.svg';
      case 'F1':
        return 'assets/sports/f1_car.svg';
      default:
        return 'assets/sports/basketball.svg'; // Default to basketball if unknown
    }
  }

  factory Rooms.fromJson(Map<String, dynamic> json) {
    DateTime? scheduledTime;
    if (json['scheduled_time'] != null) {
      try {
        scheduledTime = DateTime.parse(json['scheduled_time']);
      } catch (e) {
        print('Error parsing scheduled_time: $e');
      }
    }
    
    final league = json['league'] ?? 'NBA';
    final team1 = json['home_team'] ?? '';
    final team2 = json['away_team'] ?? '';
    
    return Rooms(
      League: league, 
      Team1: team1,
      Team2: team2,
      Logo1: json['home_team_logo'] ?? '',
      Logo2: json['away_team_logo'] ?? '',
      Sport: getSportIconForLeague(league),
      People: json['people'] ?? '',
      Remain: json['remain'] ?? 'TBD',
      state: json['status'] ?? 'Scheduled',
      icon: CupertinoIcons.dot_radiowaves_left_right,
      gameId: json['id']?.toString() ?? '',
      scheduled_time: scheduledTime,
      team1_abbr: nbaTeams[team1] ?? team1,
      team2_abbr: nbaTeams[team2] ?? team2,
    );
  }

  bool isGameLive() {
    if (scheduled_time == null) return false;
    
    final now = DateTime.now();
    final gameEndTime = scheduled_time!.add(Duration(hours: 3));
    
    return now.isAfter(scheduled_time!) && now.isBefore(gameEndTime);
  }

  String getCurrentStatus() {
    if (scheduled_time == null) return state;
    
    final now = DateTime.now();
    final gameEndTime = scheduled_time!.add(Duration(hours: 3));
    
    if (now.isBefore(scheduled_time!)) {
      return 'Scheduled';
    } else if (now.isAfter(scheduled_time!) && now.isBefore(gameEndTime)) {
      return 'Live now';
    } else {
      return 'Finished';
    }
  }
}
