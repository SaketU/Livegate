import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedButtons extends StatefulWidget {
  const FeedButtons({Key? key}) : super(key: key);

  @override
  _FeedButtonsState createState() => _FeedButtonsState();
}

class _FeedButtonsState extends State<FeedButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(padding: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              children: [
                GestureDetector(
                  onTap: () {

                  },
                  child: Icon(CupertinoIcons.heart, color: Colors.grey.shade500, size: 25,),
                ),
                SizedBox(width: 5,),
                Text('132k'),
              ],
            ),

            Row(
              children: [
                GestureDetector(
                  onTap: () {

                  },
                  child: Icon(CupertinoIcons.chat_bubble, color: Colors.grey.shade500, size: 25,),
                ),
                SizedBox(width: 5,),
                Text('132k'),
              ],
            ),

            Row(
              children: [
                GestureDetector(
                  onTap: () {

                  },
                  child: Icon(CupertinoIcons.paperplane, color: Colors.grey, size: 27,),
                ),
                SizedBox(width: 5,),
                Text('132k'),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
