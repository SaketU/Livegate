import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullapp/models/Rooms.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/widgets/chats.dart';
import 'package:fullapp/widgets/liveList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullapp/screens/searchPage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fullapp/config.dart';


//code
class LivesPage extends StatefulWidget {

  final VoidCallback showUpcomingPage;
  final VoidCallback showMoreOptions;

  const LivesPage({required this.showUpcomingPage, required this.showMoreOptions});

  @override
  _LivesPageState createState() => _LivesPageState();
}

class _LivesPageState extends State<LivesPage> {
  late Future<List<Rooms>> futureRooms;

  @override
  void initState() {
    super.initState();
    futureRooms = fetchNBAGames();
  }

  Future<List<Rooms>> fetchNBAGames() async {
    
    final response = await http.get(Uri.parse('$kBackendBaseUrl/api/nba-games'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      //convert to list of rooms
      return jsonData.map((data) => Rooms.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load NBA games');
    }
  }
  // List<Rooms> rooms = [
  //   Rooms(League: "NBA", Team1: "Lakers", Team2: "Warriors", Logo1: 'https://cdn.iconscout.com/icon/free/png-256/free-los-angeles-lakers-logo-icon-download-in-svg-png-gif-file-formats--nba-basketball-pack-logos-icons-1593200.png?f=webp&w=256', Logo2: 'https://res.cloudinary.com/vistaprint/images/c_scale,w_448,h_448,dpr_2/f_auto,q_auto/v1705418080/ideas-and-advice-prod/en-us/838px-Golden_State_Warriors_logo.svg_/838px-Golden_State_Warriors_logo.svg_.png?_i=AA', Sport: 'assets/basketball-icon.svg', People :'1.2k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
  //   Rooms(League: "NBA", Team1: "Cavaliers", Team2: "Knicks", Logo1: '', Logo2: '', Sport: '', People :'1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
  //   Rooms(League: "NBA", Team1: "Mavericks", Team2: "Bulls", Logo1: '', Logo2: '', Sport: '', People :'570', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
  //   Rooms(League: "NCAA", Team1: "Texas", Team2: "Alabama", Logo1: '', Logo2: '', Sport: '', People :'1.4k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
  //   Rooms(League: "NCAA", Team1: "LSU", Team2: "Clemson", Logo1: '', Logo2: '', Sport: '', People :'1.1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
  //   Rooms(League: "NCAA", Team1: "LSU", Team2: "Clemson", Logo1: '', Logo2: '', Sport: '', People :'1.1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
  //   Rooms(League: "NCAA", Team1: "LSU", Team2: "Clemson", Logo1: '', Logo2: '', Sport: '', People :'1.1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
  //   Rooms(League: "NCAA", Team1: "LSU", Team2: "Clemson", Logo1: '', Logo2: '', Sport: '', People :'1.1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
  //   Rooms(League: "NCAA", Team1: "LSU", Team2: "Clemson", Logo1: '', Logo2: '', Sport: '', People :'1.1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),
  //   Rooms(League: "NCAA", Team1: "LSU", Team2: "Clemson", Logo1: '', Logo2: '', Sport: '', People :'1.1k', Remain: "1 hr left", state: "Live now", icon: CupertinoIcons.dot_radiowaves_left_right),

  //];



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

              leading: Padding(
                padding: EdgeInsets.only(left: 31),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => ProfilePage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0); // Start from bottom
                            const end = Offset.zero; // End at normal position
                            const curve = Curves.easeInOut;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(position: offsetAnimation, child: child);
                          },
                        ),
                      );
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
                  padding: EdgeInsets.only(right: 31),//when chat bubble 20
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
                /*
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
                */
              ],
        
              // Add the row as part of the AppBar's bottom
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50), // Height of the row container
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                ? Color(0xFF121212)
                : Colors.white,
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
              sliver: SliverToBoxAdapter(
                child: FutureBuilder<List<Rooms>>(
                  future: futureRooms,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No games available.'));
                    }
                    final List<Rooms> rooms = snapshot.data!;
                    return Column(
                      children: rooms.map((room) {
                        return LiveList(
                          league: room.League,
                          team1: room.Team1,
                          team2: room.Team2,
                          logo1: room.Logo1,
                          logo2: room.Logo2,
                          sport: room.Sport,
                          people: room.People,
                          remain: room.Remain,
                          state: room.state,
                          icon: room.icon,
                          isLive: room.state.toLowerCase() == 'live now',
                          gameId: room.gameId,
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}