import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullapp/models/Rooms.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/widgets/chats.dart';
import 'package:fullapp/widgets/liveList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullapp/screens/searchPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fullapp/config.dart';

class LeaguesPage extends StatefulWidget {
  final String? league;

  const LeaguesPage({Key? key, this.league}) : super(key: key);

  @override
  _LeaguesPageState createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  List<Rooms> rooms = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchGames();
  }

  Future<void> fetchGames() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final league = widget.league ?? 'NBA';
      String endpoint = '';
      
      // Map league names to backend endpoints
      switch (league.toUpperCase()) {
        case 'NBA':
          endpoint = '/api/nba-games';
          break;
        case 'MLB':
        case 'NFL':
        case 'NHL':
        case 'NCAAF':
        case 'NCAAB':
        case 'COLLEGE BASEBALL':
        case 'F1':
          // These endpoints don't exist yet, show empty state
          setState(() {
            isLoading = false;
            rooms = [];
          });
          return;
        default:
          // For unsupported leagues, show empty state
          setState(() {
            isLoading = false;
            rooms = [];
          });
          return;
      }

      final response = await http.get(
        Uri.parse('$kBackendBaseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> gamesData = json.decode(response.body);
        final List<Rooms> fetchedRooms = gamesData.map((game) {
          return Rooms.fromJson({
            ...game,
            'league': league,
          });
        }).toList();

        setState(() {
          rooms = fetchedRooms;
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          errorMessage = 'Failed to load games';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = 'Network error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final league = widget.league ?? 'NBA';
    
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
              title: Text(league, style: GoogleFonts.interTight(color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.bold, fontSize: screenHeight*0.021),),
              
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
              ],
            ),
        
            // SliverList for the main content
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 21, vertical: 17),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (isLoading) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    
                    if (hasError) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Column(
                            children: [
                              Text(
                                'Error loading games',
                                style: GoogleFonts.interTight(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.onTertiary,
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: fetchGames,
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    
                    if (rooms.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Text(
                            'No games available at the moment',
                            style: GoogleFonts.interTight(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onTertiary,
                            ),
                          ),
                        ),
                      );
                    }
                    
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
                      isLive: rooms[index].state.toLowerCase().contains('live'),
                      gameId: rooms[index].gameId,
                    );
                  },
                  childCount: isLoading || hasError || rooms.isEmpty ? 1 : rooms.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}