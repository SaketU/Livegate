import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fullapp/models/Rooms.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fullapp/config.dart';
import 'package:fullapp/widgets/liveList.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _searchBarWidth;
  late Animation<double> _cancelButtonOpacity;
  late Animation<Offset> _cancelButtonSlide;
  TextEditingController _searchController = TextEditingController();
  List<Rooms> allRooms = [];
  List<Rooms> filteredRooms = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _searchBarWidth = Tween<double>(begin: 1.08, end: 0.99)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _cancelButtonOpacity = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _cancelButtonSlide = Tween<Offset>(begin: Offset(0.4, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
    _searchController.addListener(_onSearchChanged);
    _fetchRooms();
  }

  Future<void> _fetchRooms() async {
    try {
      final response = await http.get(Uri.parse('$kBackendBaseUrl/api/nba-games'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          allRooms = jsonData.map((data) => Rooms.fromJson(data)).toList();
          isLoading = false;
        });
        _onSearchChanged(); // Initial filter
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load rooms');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching rooms: $e');
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredRooms = allRooms;
      } else {
        filteredRooms = allRooms.where((room) {
          return room.Team1.toLowerCase().contains(query) ||
                 room.Team2.toLowerCase().contains(query) ||
                 room.League.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Hero(
                      tag: "searchBar",
                      child: Material(
                        color: Colors.transparent,
                        child: AnimatedBuilder(
                          animation: _searchBarWidth,
                          builder: (context, child) {
                            return FractionallySizedBox(
                              widthFactor: _searchBarWidth.value,
                              child: Container(
                                height: screenHeight * 0.045,
                                child: TextField(
                                  controller: _searchController,
                                  autofocus: true,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    hintText: "Search...", //Search teams or leagues
                                    hintStyle: GoogleFonts.interTight(color: Colors.grey.shade600),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: SvgPicture.asset(
                                          'assets/search-icon.svg',
                                          colorFilter: ColorFilter.mode(
                                            Colors.grey.shade600,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Theme.of(context).brightness == Brightness.dark
                                        ? Color(0Xff242525)
                                        : Colors.black12,
                                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black12),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.only(right: 4.0, left: screenHeight*0.013),
                    child: SlideTransition(
                      position: _cancelButtonSlide,
                      child: FadeTransition(
                        opacity: _cancelButtonOpacity,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.inter(
                              fontSize: screenHeight*0.019,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredRooms.isEmpty
                  ? Center(
                      child: Text(
                        _searchController.text.isEmpty
                            ? "Search for teams or leagues"
                            : "No matches found",
                        style: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: screenHeight * 0.018,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 21, vertical: 17),
                      itemCount: filteredRooms.length,
                      itemBuilder: (context, index) {
                        final room = filteredRooms[index];
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
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}