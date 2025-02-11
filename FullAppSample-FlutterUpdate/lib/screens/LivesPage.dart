import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullapp/models/Rooms.dart';
import 'package:fullapp/screens/chatDocumentsPage.dart';
import 'package:fullapp/screens/chatPage.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/screens/upcomingPage.dart';
import 'package:fullapp/screens/usersProfilePage.dart';
import 'package:fullapp/widgets/chats.dart';
import 'package:fullapp/widgets/feedButtons.dart';
import 'package:fullapp/widgets/feedPosts.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/widgets/liveList.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:fullapp/screens/exProfilePage.dart';
import 'package:google_fonts/google_fonts.dart';

class LivesPage extends StatefulWidget {

  final VoidCallback showUpcomingPage;
  final VoidCallback showMoreOptions;

  const LivesPage({required this.showUpcomingPage, required this.showMoreOptions});

  @override
  _LivesPageState createState() => _LivesPageState();
}

class _LivesPageState extends State<LivesPage> {
  List<Rooms> rooms = [
    Rooms(League: "NBA", Teams: "Lakers vs Warriors", Logo1: 'https://cdn.iconscout.com/icon/free/png-256/free-los-angeles-lakers-logo-icon-download-in-svg-png-gif-file-formats--nba-basketball-pack-logos-icons-1593200.png?f=webp&w=256', Logo2: 'https://res.cloudinary.com/vistaprint/images/c_scale,w_448,h_448,dpr_2/f_auto,q_auto/v1705418080/ideas-and-advice-prod/en-us/838px-Golden_State_Warriors_logo.svg_/838px-Golden_State_Warriors_logo.svg_.png?_i=AA', Sport: 'https://png.pngtree.com/png-vector/20230303/ourmid/pngtree-basketball-line-icon-vector-png-image_6630761.png', People :'1.2k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NBA", Teams: "Cavaliers vs Knicks", Logo1: '', Logo2: '', Sport: '', People :'1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NBA", Teams: "Mavericks vs Bulls", Logo1: '', Logo2: '', Sport: '', People :'570', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NCAA", Teams: "Texas vs Alabama", Logo1: '', Logo2: '', Sport: '', People :'1.4k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NCAA", Teams: "LSU vs Clemson", Logo1: '', Logo2: '', Sport: '', People :'1.1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(padding: EdgeInsets.only(left: 30),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfilePage();
                }));
              },
              child: Icon(size: 28, Icons.account_circle_outlined, color: Theme
                  .of(context)
                  .colorScheme
                  .tertiary),
            ),
          ),


          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 20),
              //padding: EdgeInsets.only(right: 10),
              onPressed: () {},
              icon: Icon(size: 26, CupertinoIcons.search, color: Theme
                  .of(context)
                  .colorScheme
                  .tertiary),
            ),

            IconButton(
              padding: EdgeInsets.only(right: 24),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChatsPage();
                }));
              },
              icon: Transform(
                transform: Matrix4.identity()..scale(1, 1.15), // Thinner (width) and taller (height)
                alignment: Alignment.center, // Ensures scaling is centered
                child: Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 24, // Base size
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),

          ]
      ),

      body: Container(
        child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 65, left: 65),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Live",style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.bold, color:  Theme.of(context).colorScheme.tertiary),),

                    GestureDetector(
                      onTap: widget.showUpcomingPage,
                      child:
                      Text("Upcoming",style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.w500, color:  Theme.of(context).colorScheme.onTertiary),),
                    ),
                    GestureDetector(
                      onTap: widget.showMoreOptions,
                      child:
                      Text("More",style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.w500, color:  Theme.of(context).colorScheme.onTertiary),),
                    ),
                  ],
                ),
              ),
              Expanded(child:
              ListView.builder(
                itemCount: rooms.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 17, left: 21, right: 21, bottom: 22),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return LiveList(
                    league: rooms[index].League,
                    teams: rooms[index].Teams,
                    logo1: rooms[index].Logo1,
                    logo2: rooms[index].Logo2,
                    sport: rooms[index].Sport,
                    people: rooms[index].People,
                    remain: rooms[index].Remain,
                    state: rooms[index].state,
                    icon: rooms[index].icon,
                    isLive: true
                  );
                },
              ),
              ),
            ]
        ),
      ),
    );
  }
}
