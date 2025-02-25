import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullapp/models/Rooms.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/widgets/chats.dart';
import 'package:fullapp/widgets/liveList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
//code
class LivesPage extends StatefulWidget {

  final VoidCallback showUpcomingPage;
  final VoidCallback showMoreOptions;

  const LivesPage({required this.showUpcomingPage, required this.showMoreOptions});

  @override
  _LivesPageState createState() => _LivesPageState();
}

class _LivesPageState extends State<LivesPage> {
  List<Rooms> rooms = [
    Rooms(League: "NBA", Team1: "Lakers", Team2: "Warriors", Logo1: 'https://cdn.iconscout.com/icon/free/png-256/free-los-angeles-lakers-logo-icon-download-in-svg-png-gif-file-formats--nba-basketball-pack-logos-icons-1593200.png?f=webp&w=256', Logo2: 'https://res.cloudinary.com/vistaprint/images/c_scale,w_448,h_448,dpr_2/f_auto,q_auto/v1705418080/ideas-and-advice-prod/en-us/838px-Golden_State_Warriors_logo.svg_/838px-Golden_State_Warriors_logo.svg_.png?_i=AA', Sport: 'https://png.pngtree.com/png-vector/20230303/ourmid/pngtree-basketball-line-icon-vector-png-image_6630761.png', People :'1.2k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NBA", Team1: "Cavaliers", Team2: "Knicks", Logo1: '', Logo2: '', Sport: '', People :'1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NBA", Team1: "Mavericks", Team2: "Bulls", Logo1: '', Logo2: '', Sport: '', People :'570', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NCAA", Team1: "Texas", Team2: "Alabama", Logo1: '', Logo2: '', Sport: '', People :'1.4k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NCAA", Team1: "LSU", Team2: "Clemson", Logo1: '', Logo2: '', Sport: '', People :'1.1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NCAA", Team1: "LSU", Team2: "Clemson", Logo1: '', Logo2: '', Sport: '', People :'1.1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NCAA", Team1: "LSU", Team2: "Clemson", Logo1: '', Logo2: '', Sport: '', People :'1.1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NCAA", Team1: "LSU", Team2: "Clemson", Logo1: '', Logo2: '', Sport: '', People :'1.1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NCAA", Team1: "LSU", Team2: "Clemson", Logo1: '', Logo2: '', Sport: '', People :'1.1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NCAA", Team1: "LSU", Team2: "Clemson", Logo1: '', Logo2: '', Sport: '', People :'1.1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),

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
                      Text(
                        "Live",
                        style: GoogleFonts.interTight(
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary,
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
                      GestureDetector(
                        onTap: widget.showMoreOptions,
                        child: Text(
                          "More",
                          style: GoogleFonts.interTight(
                            fontSize: screenHeight * 0.018,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onTertiary,
                          ),
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
                      isLive: true,
                    );
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