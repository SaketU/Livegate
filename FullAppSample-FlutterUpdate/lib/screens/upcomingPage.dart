import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullapp/models/Rooms.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/widgets/chats.dart';
import 'package:fullapp/widgets/liveList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
//code
class UpcomingPage extends StatefulWidget {

  final VoidCallback showLivesPage;
  final VoidCallback showMoreOptions;

  const UpcomingPage({required this.showLivesPage, required this.showMoreOptions});

  @override
  _UpcomingPageState createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  List<Rooms> rooms = [
    Rooms(League: "NBA", Team1: "Lakers", Team2: "Warriors", Logo1: '', Logo2: '', Sport: '', People :'', Remain: "", state: "Scheduled", icon: CupertinoIcons.dot_radiowaves_left_right, gameId: "1"),
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
                      Text(
                        "Upcoming",
                        style: GoogleFonts.interTight(
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary,
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
                      isLive: (index == false || index == false) ? true : false,
                      gameId: rooms[index].gameId,
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
                      Text("Live",style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.w500, color:  Theme.of(context).colorScheme.onTertiary),),
                    ),

                    Text("Upcoming",style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.bold, color:  Theme.of(context).colorScheme.tertiary),),

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
                    team1: rooms[index].Team1,
                    team2: rooms[index].Team2,
                    logo1: rooms[index].Logo1,
                    logo2: rooms[index].Logo2,
                    sport: rooms[index].Sport,
                    people: rooms[index].People,
                    remain: rooms[index].Remain,
                    state: rooms[index].state,
                    icon: rooms[index].icon,
                    isLive: (index == false || index == false) ? true : false,
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