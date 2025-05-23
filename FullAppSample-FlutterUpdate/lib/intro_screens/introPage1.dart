import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class IntroPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        top: false,
        bottom: true,
        child: Stack(
          children: [
            /// ✅ IMAGE CONTAINER (Centers Image Without Affecting Column Alignment)
            Positioned(
              top: screenHeight * 0.015,
              left: (screenWidth - (screenWidth * 0.92)) / 2,
              child: Container(
                width: screenWidth * 0.92,
                height: screenHeight * 0.5053,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  image: DecorationImage(
                    image: AssetImage(Theme.of(context).brightness == Brightness.dark?
                      "assets/app_logos/page1_dark.png":"assets/app_logos/page1.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            /// ✅ ROW TO DISPLAY WELCOME TEXT (Prevents Overflow)
            Positioned(
              top: screenHeight * 0.58,
              left: 39,
              right: 39,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome to',
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.028,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    TextSpan(
                      text: ' Livegate!',
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.028,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            /// ✅ TEXT CONTENT (Ensures It Doesn't Overflow)
            Positioned(
              top: screenHeight * 0.63,
              left: 39,
              right: 39,
              child: Text(
                'Our live communications platform that lets you chat about sporting events in real time',
                style: GoogleFonts.interTight(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey
                      : Colors.grey.shade600,
                  fontSize: screenHeight * 0.024,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
