import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullapp/models/Rooms.dart';
import 'package:fullapp/models/moreLeagues.dart';
import 'package:fullapp/screens/NBALivesPage.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/widgets/chats.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullapp/screens/NBALivesPage.dart';
//code
class MoreOptions extends StatefulWidget {

  final VoidCallback showLivesPage;
  final VoidCallback showUpcomingPage;

  const MoreOptions({required this.showLivesPage, required this.showUpcomingPage});

  @override
  _MoreOptionsState createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> {
  List<Leagues> leagues = [
    Leagues(league: 'NFL', leagueLogo: 'assets/logos/NFL.svg'),
    Leagues(league: 'NBA', leagueLogo: 'assets/logos/NBA.svg'),
    Leagues(league: 'MLB', leagueLogo: 'assets/logos/MLB.svg'),
    Leagues(league: 'NHL', leagueLogo: 'assets/logos/NHL.svg'),
    Leagues(league: 'NCAAF', leagueLogo: 'assets/logos/NCAA.svg'),
    Leagues(league: 'NCAAB', leagueLogo: 'assets/logos/NCAA.svg'),
    Leagues(league: 'College Baseball', leagueLogo: 'assets/logos/NCAA.svg'),
    Leagues(league: 'F1', leagueLogo: 'assets/logos/F1.svg'),
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
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 3 items per row
                  mainAxisSpacing: 15, // Adjust for spacing between rows
                  crossAxisSpacing: 10, // Adjust for spacing between columns
                  childAspectRatio: 1, // Adjust for shape of items
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _buildLeagueItem(context, leagues[index]);
                  },
                  childCount: leagues.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildLeagueItem(BuildContext context, Leagues leagues) {
  
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NBALivesPage();
        }));
    },
    child: Padding(
      padding: EdgeInsets.only(bottom: screenHeight*0.013),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: screenWidth * 0.30,
            height: screenWidth * 0.30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[800]
                  : Colors.grey[200],
            ),
            child: Center(
              child: SvgPicture.asset(
                leagues.leagueLogo,
                width: screenWidth * 0.15,//0.095
                height: screenWidth * 0.15,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            leagues.league,
            style: GoogleFonts.interTight(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
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