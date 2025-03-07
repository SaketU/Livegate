import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _searchBarWidth;
  late Animation<double> _cancelButtonOpacity;
  late Animation<Offset> _cancelButtonSlide;

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
  }

  @override
  void dispose() {
    _controller.dispose();
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
                                  autofocus: true,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    hintText: "Search...",
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
                  
                  // Reduced spacing on the right of "Cancel"
                  Padding(
                    padding: EdgeInsets.only(right: 4.0, left: screenHeight*0.013), // 👈 This reduces space
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
              child: Center(child: Text("Search results appear here...")),
            ),
          ],
        ),
      ),
    );
  }
}