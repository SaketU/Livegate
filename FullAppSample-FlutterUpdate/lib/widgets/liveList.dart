import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/screens/LiveRoomPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullapp/widgets/friendsBottomSheet.dart';
//code
class LiveList extends StatefulWidget{
  String league;
  String team1;
  String team2;
  String logo1;
  String logo2;
  String sport;
  String people;
  String remain;
  String state;
  IconData icon;

  bool isLive;
  LiveList({required this.league,required this.team1,required this.team2, required this.logo1,required this.logo2,required this.sport,required this.people,required this.remain,required this.state,required this.icon, required this.isLive});
  @override
  _LiveListState createState() => _LiveListState();
}

class _LiveListState extends State<LiveList> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
          height: screenHeight * 0.105,//101
          width: 386,//386
          padding: EdgeInsets.only(left: 15, right: 26, top: screenHeight * 0.014),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.league,
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.017,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark?
                        Theme.of(context).colorScheme.onTertiary : Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Row(
                      children: [
                        Text(
                          widget.team1,
                          style: GoogleFonts.interTight(
                            fontSize: screenHeight * 0.017,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Text(
                      ' vs ',
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.017,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                        Text(
                      widget.team2,
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.017,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          child: Row(
                            children: [
                              if (widget.isLive) ...[
                                SvgPicture.asset(
                                  'assets/live-icon.svg',
                                  width: screenWidth * 0.0145, // Adjust size as needed
                                  height: screenHeight * 0.010,
                                  colorFilter: ColorFilter.mode(
                                  Colors.red,  // Change to any color you need
                                  BlendMode.srcIn,  // Ensures proper color blending
                                  ),
                  ),
                                /*
                                Icon(
                                  widget.icon,
                                  color: Colors.red,
                                  size: screenHeight * 0.016,
                                ),
                                */
                                SizedBox(width: 8),
                              ],
                              Text(
                                widget.state,
                                style: GoogleFonts.interTight(
                                  fontSize: screenHeight * 0.012,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onTertiary,
                                ),
                              ),
                              SizedBox(width: 28),
                              widget.isLive
                                  ? Text(
                                widget.remain,
                                style: GoogleFonts.interTight(
                                  fontSize: screenHeight * 0.012,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onTertiary,
                                ),
                              )
                                  : Icon(
                                CupertinoIcons.bell,
                                color: Colors.grey.shade700,
                                size: screenHeight * 0.016,
                              ),
                              SizedBox(width: 28),
                              IconButton(
                                padding: EdgeInsets.only(bottom: 1),
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => FriendsBottomSheet(),
                                  );
                                },
                                icon: Icon(
                                  CupertinoIcons.paperplane,
                                  size: screenHeight * 0.016,
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
                width: screenWidth * 0.16, // Adjust size as needed
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: screenHeight * 0.030,//30
                      bottom: screenHeight * 0.021,//17
                      child: CircleAvatar(
                        radius: screenHeight * 0.022,//20
                        backgroundColor: Theme.of(context).brightness == Brightness.dark?
                        Colors.white10 : Colors.grey.shade400,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Transform.scale(
                              scale: 0.8, // Adjust the scale factor to make the image smaller
                              child: Image.network(//change to svg
                                widget.logo2,
                                fit: BoxFit.cover, // Ensures the image covers the area appropriately
                              ),
                            )
                        ),// Adjust color as needed
                      ),
                    ), //bottom right
                    Positioned(
                      left: screenHeight * 0.0,//0.0
                      bottom: screenHeight * 0.039,//35
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
                        children: [
                          CircleAvatar(
                            radius: screenHeight * 0.022,//20
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: CircleAvatar(
                              radius: screenHeight * 0.021,//19
                              backgroundColor: Theme.of(context).brightness == Brightness.dark?
                              Colors.white10 : Colors.grey.shade400,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Transform.scale(
                                    scale: 0.8, // Adjust the scale factor to make the image smaller
                                    child: Image.network( //change to svg
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
                                  style: GoogleFonts.interTight(
                                    fontSize: screenHeight * 0.012,
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
                      left: screenHeight * 0.005,
                      top: screenHeight * 0.045,//4
                      child: CircleAvatar(
                        radius: screenHeight * 0.016,//14
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: CircleAvatar(
                          radius: screenHeight * 0.015,//13
                          backgroundColor: Theme.of(context).brightness == Brightness.dark?
                          Colors.white10 : Colors.grey.shade400,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Transform.scale(
                              scale: 0.8, // Adjust the scale factor to make the image smaller
                              child: SvgPicture.asset( //this change now allows me to display svg, before it was image.network
                                widget.sport,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.tertiary,  // Change to any color you need
                                BlendMode.srcIn,  // Ensures proper color blending
                                ), // Ensures the image covers the area appropriately
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
}

//Original look, responsive
/*
Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
          height: 99,//99
          width: 386,//386
          padding: EdgeInsets.only(left: 15, right: 26, top: 14),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.league,
                      style: GoogleFonts.interTight(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.teams,
                      style: GoogleFonts.interTight(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    SizedBox(height: 9),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          child: Row(
                            children: [
                              if (widget.isLive) ...[
                                Icon(
                                  widget.icon,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                              ],
                              Text(
                                widget.state,
                                style: GoogleFonts.interTight(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onTertiary,
                                ),
                              ),
                              SizedBox(width: 28),
                              widget.isLive
                                  ? Text(
                                widget.remain,
                                style: GoogleFonts.interTight(
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
                        radius: 20,
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
                            radius: 20,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: CircleAvatar(
                              radius: 19,
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
                                  style: GoogleFonts.interTight(
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
                        radius: 14,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: CircleAvatar(
                          radius: 13,
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
*/


//Responsive all across
/*
Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
          height: screenHeight * 0.101,//99
          width: 386,//386
          padding: EdgeInsets.only(left: 15, right: 26, top: screenHeight * 0.014),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.league,
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.015,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      widget.teams,
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.015,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.009),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          child: Row(
                            children: [
                              if (widget.isLive) ...[
                                Icon(
                                  widget.icon,
                                  color: Colors.red,
                                  size: screenHeight * 0.016,
                                ),
                                SizedBox(width: 8),
                              ],
                              Text(
                                widget.state,
                                style: GoogleFonts.interTight(
                                  fontSize: screenHeight * 0.012,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onTertiary,
                                ),
                              ),
                              SizedBox(width: 28),
                              widget.isLive
                                  ? Text(
                                widget.remain,
                                style: GoogleFonts.interTight(
                                  fontSize: screenHeight * 0.012,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onTertiary,
                                ),
                              )
                                  : Icon(
                                CupertinoIcons.bell,
                                color: Colors.grey.shade700,
                                size: screenHeight * 0.016,
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
                                  size: screenHeight * 0.016,
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
                width: screenWidth * 0.15, // Adjust size as needed
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: screenHeight * 0.030,
                      bottom: screenHeight * 0.021,//17
                      child: CircleAvatar(
                        radius: screenHeight * 0.020,
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
                      left: screenHeight * 0.0,
                      bottom: screenHeight * 0.039,//35
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
                        children: [
                          CircleAvatar(
                            radius: screenHeight * 0.020,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: CircleAvatar(
                              radius: screenHeight * 0.019,
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
                                  style: GoogleFonts.interTight(
                                    fontSize: screenHeight * 0.012,
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
                      left: screenHeight * 0.005,
                      top: screenHeight * 0.04,//4
                      child: CircleAvatar(
                        radius: screenHeight * 0.014,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: CircleAvatar(
                          radius: screenHeight * 0.013,
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
*/