import 'package:flutter/cupertino.dart';

import 'package:uuid/uuid.dart';

class RoomMessage {
  String id; // Unique ID for each message
  String name;
  String profileImage;
  String messageContent;
  String messageType;
  bool selected;
  Map<String, int> reactions; // Changed from List<String> to Map<String, int>

  RoomMessage({
    String? id,
    required this.name,
    required this.profileImage,
    required this.messageContent,
    required this.messageType,
    required this.selected,
    Map<String, int>? reactions, // Updated type
  })  : id = id ?? const Uuid().v4(),
        reactions = reactions ?? {}; // Initialize as empty map if null
}