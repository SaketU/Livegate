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


  factory Rooms.fromJson(Map<String, dynamic> json) {
    return Rooms(
      League: json['league'] ?? 'NBA', 
      Team1: json['home_team'] ?? '',
      Team2: json['away_team'] ?? '',
      Logo1: json['home_team_logo'] ?? '',
      Logo2: json['away_team_logo'] ?? '',
      Sport: json['sport'] ?? '',
      People: json['people'] ?? '',
      Remain: json['remain'] ?? 'TBD',
      state: json['status'] ?? 'Scheduled',
      icon: CupertinoIcons.dot_radiowaves_left_right,
      gameId: json['id']?.toString() ?? '',
    );
  }
}
