import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MembersList extends StatefulWidget {
  String name;
  String profileImage;
  MembersList({required this.name, required this.profileImage});

  @override
  _MembersListState createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image:
                      NetworkImage(widget.profileImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name,style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}