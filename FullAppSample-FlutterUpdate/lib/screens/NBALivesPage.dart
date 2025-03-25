import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullapp/models/Rooms.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/widgets/chats.dart';
import 'package:fullapp/widgets/liveList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullapp/screens/searchPage.dart';

class NBALivesPage extends StatefulWidget {

  @override
  _NBALivesPageState createState() => _NBALivesPageState();
}

class _NBALivesPageState extends State<NBALivesPage> {
  List<Rooms> rooms = [
    Rooms(League: "NBA", Team1: "Lakers", Team2: "Warriors", Logo1: '', Logo2: '', Sport: 'assets/basketball-icon.svg', People :'1.2k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NBA", Team1: "Cavaliers", Team2: "Knicks", Logo1: '', Logo2: '', Sport: 'assets/basketball-icon.svg', People :'1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NBA", Team1: "Mavericks", Team2: "Bulls", Logo1: '', Logo2: '', Sport: 'assets/basketball-icon.svg', People :'570', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    Rooms(League: "NBA", Team1: "Heats", Team2: "Cavaliers", Logo1: '', Logo2: '', Sport: 'assets/basketball-icon.svg', People :'1.4k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
    
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
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Color(0xFF121212)
                : Colors.white,
              elevation: 0,
              floating: true,
              snap: true, // Ensures the AppBar snaps into place when scrolling up
              pinned: false, // Keeps AppBar visible at the top
              
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.back,
                  size: 30,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => SearchPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
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