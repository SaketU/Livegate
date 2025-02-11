import 'package:flutter/cupertino.dart';
import 'package:fullapp/screens/chatDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/screens/LiveRoomPage.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveList extends StatefulWidget{
  String league;
  String teams;
  String logo1;
  String logo2;
  String sport;
  String people;
  String remain;
  String state;
  IconData icon;

  bool isLive;
  LiveList({required this.league,required this.teams,required this.logo1,required this.logo2,required this.sport,required this.people,required this.remain,required this.state,required this.icon, required this.isLive});
  @override
  _LiveListState createState() => _LiveListState();
}

class _LiveListState extends State<LiveList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LiveRoomPage();
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 22.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.primary,
          ),
          height: 99,
          width: 386,
          padding: EdgeInsets.only(left: 15, right: 26, top: 14),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.league,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.teams,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    SizedBox(height: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 19),
                        child: Container(
                          child: Row(
                            children: [
                              if (widget.isLive) ...[
                                Icon(
                                  widget.icon,
                                  color: Colors.red,
                                  size: 14,
                                ),
                                SizedBox(width: 8),
                              ],
                              Text(
                                widget.state,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onTertiary,
                                ),
                              ),
                              SizedBox(width: 28),
                              widget.isLive
                                  ? Text(
                                widget.remain,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onTertiary,
                                ),
                              )
                                  : Icon(
                                CupertinoIcons.bell,
                                color: Colors.grey.shade700,
                                size: 16,
                              ),
                              SizedBox(width: 28),
                              IconButton(
                                padding: EdgeInsets.only(bottom: 1),
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => buildSheet(),
                                  );
                                },
                                icon: Icon(
                                  CupertinoIcons.paperplane,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.onTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Adding the three overlapping circles
              SizedBox(
                width: 80, // Adjust size as needed
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 30,
                      bottom: 17,
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey.shade400,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                            child: Transform.scale(
                              scale: 0.8, // Adjust the scale factor to make the image smaller
                              child: Image.network(
                                widget.logo2,
                                fit: BoxFit.cover, // Ensures the image covers the area appropriately
                              ),
                            )
                        ),// Adjust color as needed
                      ),
                    ), //bottom right
                    Positioned(
                      left: 0,
                      bottom: 35,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.grey.shade400,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                  child: Transform.scale(
                                    scale: 0.8, // Adjust the scale factor to make the image smaller
                                    child: Image.network(
                                      widget.logo1,
                                      fit: BoxFit.cover, // Ensures the image covers the area appropriately
                                    ),
                                  )
                              ),// Adjust color as needed
                            ),
                          ),
                          SizedBox(width: 5),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 8), // Move text higher
                                child: Text(
                                  widget.people,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).colorScheme.onTertiary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ), // top left
                    Positioned(
                      left: 5,
                      top: 40,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey.shade400,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Transform.scale(
                              scale: 0.8, // Adjust the scale factor to make the image smaller
                              child: Image.network(
                                widget.sport,
                                fit: BoxFit.cover, // Ensures the image covers the area appropriately
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //small
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget makeDismissible ({required Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.of(context).pop(),
    child: GestureDetector(onTap: () {}, child: child,),
  );

  //share to chats or other apps
  Widget buildSheet() => makeDismissible(
    child: DraggableScrollableSheet(
      initialChildSize: 0.75,
      builder: (_, controller) =>
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 20),
            child: ListView(
              controller: controller,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  width: double.infinity,
                  height: 35,
                  child: TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(CupertinoIcons.search,color: Colors.grey.shade600,size: 25,),
                      filled: true,
                      fillColor: Colors.black12,
                      contentPadding: EdgeInsets.all(3),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    ),
  );
}