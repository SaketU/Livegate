import 'package:fullapp/screens/chatDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  String profileImage;
  String time;
  bool isMessageRead;
  ConversationList({
    required this.name,
    required this.messageText,
    required this.profileImage,
    required this.time,
    required this.isMessageRead,
  });
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailPage(
            name: widget.name,
            profileImage: widget.profileImage,
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.profileImage),
                    maxRadius: screenHeight*0.033,
                  ),
                  SizedBox(width: screenWidth*0.022),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: GoogleFonts.interTight(
                              fontSize: screenHeight*0.018,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 1),
                          Text(
                            widget.messageText,
                            maxLines: 1,  // Ensures the text stays on one line
                            overflow: TextOverflow.ellipsis,  // Adds "..." when the text overflows
                            style: GoogleFonts.interTight(
                              fontSize: screenHeight * 0.018,
                              fontWeight: widget.isMessageRead ? FontWeight.bold : FontWeight.normal,
                              color: widget.isMessageRead
                                  ? Theme.of(context).colorScheme.tertiary
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  if (widget.isMessageRead)
                    Container(
                      width: screenHeight*0.011,
                      height: screenHeight*0.011,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFD80E),
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.only(right: screenHeight*0.011),
                    ),
                  Text(
                    widget.time,
                    style: GoogleFonts.interTight(
                      fontSize: screenHeight*0.018,
                      fontWeight: widget.isMessageRead
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: widget.isMessageRead
                                    ? Theme.of(context).colorScheme.tertiary//not read
                                    : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}