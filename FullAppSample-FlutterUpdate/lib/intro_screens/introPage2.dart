import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage2 extends StatelessWidget {
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
              left: (screenWidth - (screenWidth * 0.82)) / 2,
              child: Container(
                width: screenWidth * 0.82,
                height: screenHeight * 0.5053,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  image: DecorationImage(
                    image: AssetImage("lib/Images App/live-page.png"),
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
                      text: 'Active',
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.028,
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' Experience',
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.028,
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
                'Join in on the conversation of your favorite games and share every moment ',
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
