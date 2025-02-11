import 'package:flutter/cupertino.dart';

class RoomMessage{
  String name;
  String profileImage;
  String messageContent;
  String messageType;
  bool selected;
  RoomMessage({required this.name, required this.profileImage, required this.messageContent, required this.messageType, required this.selected});
}
