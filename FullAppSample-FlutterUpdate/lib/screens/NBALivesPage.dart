import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullapp/models/Rooms.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/widgets/chats.dart';
import 'package:fullapp/widgets/liveList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullapp/screens/searchPage.dart';
import 'package:fullapp/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fullapp/widgets/shimmer_loading.dart';

class NBALivesPage extends StatefulWidget {
  @override
  _NBALivesPageState createState() => _NBALivesPageState();
}

class _NBALivesPageState extends State<NBALivesPage> {
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
      return jsonData.map((data) => Rooms.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load NBA games');
    }
  }

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
              snap: true,
              pinned: false,
              title: Text(
                'NBA',
                style: GoogleFonts.interTight(
                  fontSize: screenHeight * 0.02,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
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
            ),
        
            // SliverList for the main content
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 21, vertical: 17),
              sliver: SliverToBoxAdapter(
                child: FutureBuilder<List<Rooms>>(
                  future: futureRooms,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: List.generate(5, (index) => ShimmerLiveList()),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No games available.'));
                    }
                    
                    final List<Rooms> rooms = snapshot.data!;
                    return Column(
                      children: rooms.map((room) {
                        return LiveList(
                          room: room,
                          isLive: room.getCurrentStatus() == 'Live now',
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