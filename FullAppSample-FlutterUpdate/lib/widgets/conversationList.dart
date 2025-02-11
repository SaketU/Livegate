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
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailPage();
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
                    maxRadius: 28,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.messageText,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: widget.isMessageRead
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: widget.isMessageRead
                                  ? Theme.of(context).colorScheme.tertiary
                                  : Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                if (widget.isMessageRead)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      shape: BoxShape.circle,
                    ),
                    margin: EdgeInsets.only(right: 8),
                  ),
                Text(
                  widget.time,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: widget.isMessageRead
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
