import 'package:flutter/material.dart';

class Friend {
  String name;
  String profileImage;
  bool isSelected;

  Friend({required this.name, required this.profileImage, this.isSelected = false});
}