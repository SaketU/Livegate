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
    final league = json['league'] ?? 'NBA';
    
    return Rooms(
      League: league,
      Team1: json['home_team'] ?? '',
      Team2: json['away_team'] ?? '',
      Logo1: json['home_team_logo'] ?? '',
      Logo2: json['away_team_logo'] ?? '',
      Sport: getSportIconForLeague(league),
      People: json['people'] ?? '',
      Remain: json['remain'] ?? 'TBD',
      state: json['status'] ?? 'Scheduled',
      icon: CupertinoIcons.dot_radiowaves_left_right,
      gameId: json['id']?.toString() ?? '',
    );
  }
}
