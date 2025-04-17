import 'package:flutter/cupertino.dart';

import 'package:uuid/uuid.dart';

class RoomMessage {
  String id; // Unique ID for each message
  final String name;
  final String profileImage;
  final String messageContent;
  final String messageType;
  bool selected;
  Map<String, int> reactions;
  // New fields for reply functionality
  RoomMessage? replyTo;
  String? replyToName;

  RoomMessage({
    String? id,
    required this.name,
    required this.profileImage,
    required this.messageContent,
    required this.messageType,
    this.selected = false,
    Map<String, int>? reactions,
    this.replyTo,
    this.replyToName,
  })  : id = id ?? const Uuid().v4(),
        reactions = reactions ?? {}; // Initialize as empty map if null
}