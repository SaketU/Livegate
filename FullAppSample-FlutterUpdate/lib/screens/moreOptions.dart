import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullapp/models/Rooms.dart';
import 'package:fullapp/screens/chatDocumentsPage.dart';
import 'package:fullapp/screens/chatPage.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/screens/usersProfilePage.dart';
import 'package:fullapp/widgets/chats.dart';
import 'package:fullapp/widgets/feedButtons.dart';
import 'package:fullapp/widgets/feedPosts.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/widgets/liveList.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:fullapp/screens/exProfilePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
//code
class MoreOptions extends StatefulWidget {

  final VoidCallback showLivesPage;
  final VoidCallback showUpcomingPage;

  const MoreOptions({required this.showLivesPage, required this.showUpcomingPage});

  @override
  _MoreOptionsState createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> {
  List<Rooms> rooms = [
    Rooms(League: "NBA", Team1: "Lakers",Team2: "Warrios", Logo1: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg', Logo2: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg', Sport: '', People :'1.2k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
  ];

@override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        top: true,
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // SliverAppBar with floating behavior
            SliverAppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              elevation: 0,
              floating: true,
              snap: true, // Ensures the AppBar snaps into place when scrolling up
              pinned: false, // Keeps AppBar visible at the top
              
              leading: Padding(
                padding: EdgeInsets.only(left: 31),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return ProfilePage();
                    }));
                  },
                  child: SvgPicture.asset(
                    'assets/Profile-Icon.svg',
                    width: screenWidth * 0.025, // Adjust size as needed
                    height: screenHeight * 0.025,
                    colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.tertiary,  // Change to any color you need
                    BlendMode.srcIn,  // Ensures proper color blending
                    ),
                  ),
                  
                  /*Icon(
                    size: 28,
                    Icons.account_circle_outlined,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  */
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: SvgPicture.asset(
                    'assets/search-icon.svg',
                    width: screenWidth * 0.027, // Adjust size as needed
                    height: screenHeight * 0.027,
                    colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.tertiary,  // Change to any color you need
                    BlendMode.srcIn,  // Ensures proper color blending
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 31.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ChatsPage();
                      }));
                    },
                    child: SvgPicture.asset(
                        'assets/chat-icon.svg',
                        width: screenWidth * 0.027, // Adjust size as needed
                        height: screenHeight * 0.027,
                        colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.tertiary,  // Change to any color you need
                        BlendMode.srcIn,  // Ensures proper color blending
                        ),
                      ),
                  ),
                ),
                /*
                IconButton(
                  padding: EdgeInsets.only(right: 31),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return ChatsPage();
                    }));
                  },
                  icon: Transform(
                    transform: Matrix4.identity()..scale(1, 1.15),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 24,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
                */
              ],
        
              // Add the row as part of the AppBar's bottom
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50), // Height of the row container
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: widget.showLivesPage,
                        child: Text(
                          "Live",
                          style: GoogleFonts.interTight(
                            fontSize: screenHeight * 0.018,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onTertiary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showUpcomingPage,
                        child: Text(
                          "Upcoming",
                          style: GoogleFonts.interTight(
                            fontSize: screenHeight * 0.018,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onTertiary,
                          ),
                        ),
                      ),
                      Text(
                        "More",
                        style: GoogleFonts.interTight(
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        
            // SliverList for the main content
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 21, vertical: 17),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    
                  },
                  childCount: rooms.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
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
                    GestureDetector(
                      onTap: widget.showLivesPage,
                      child:
                      Text("Live",style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.w600, color:  Theme.of(context).colorScheme.onTertiary),),
                    ),
                    GestureDetector(
                      onTap: widget.showUpcomingPage,
                      child:
                      Text("Upcoming",style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.w600, color:  Theme.of(context).colorScheme.onTertiary),),
                    ),
                    Text("More",style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.bold, color:  Theme.of(context).colorScheme.tertiary),),
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
                    team1: rooms[index].Team1,
                    team2: rooms[index].Team2,
                    logo1: rooms[index].Logo1,
                    logo2: rooms[index].Logo2,
                    sport: rooms[index].Sport,
                    people: rooms[index].People,
                    remain: rooms[index].Remain,
                    state: rooms[index].state,
                    icon: rooms[index].icon,
                    isLive: (index == 0 || index == 3) ? true : false,
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
*/