import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  void Function()? onTap;
  LikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isLiked ? CupertinoIcons.heart_solid: CupertinoIcons.heart, color: isLiked? Colors.red: Colors.grey,
      ),
    );
  }
}
