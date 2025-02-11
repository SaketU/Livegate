import 'package:flutter/material.dart';



class MyPosts extends StatefulWidget{
  @override
  _MyPostsPageState createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Container(
        width: double.infinity,
        height: 560,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(25),

        ),
      ),
    );
  }
}