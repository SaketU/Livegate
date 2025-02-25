import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class IntroPage3 extends StatelessWidget {
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
            /// ✅ IMAGE CONTAINER (Left-aligned image)
            Positioned(
              top: screenHeight * 0.015,
              left: 24,
              child: Container(
                width: screenWidth * 0.458,
                height: screenHeight * 0.456,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  image: DecorationImage(
                    image: AssetImage("lib/Images App/live-page.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            /// ✅ RIGHT-SIDE TEXT CONTENT
            Positioned(
              top: screenHeight * 0.133,
              left: screenWidth * 0.55,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore',
                    style: GoogleFonts.interTight(
                      fontSize: screenHeight * 0.028,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.014),
                  Text(
                    'Find new people and make connections through active conversations and active interactions',
                    style: GoogleFonts.interTight(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey
                          : Colors.grey.shade600,
                      fontSize: screenHeight * 0.024,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
            
            /// ✅ CONNECT SECTION
            Positioned(
              top: screenHeight * 0.58,
              left: 39,
              right: 39,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Connect',
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.028,
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' with Others',
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
                'Never watch a game alone. Discuss every play, call, or favorite moment with others',
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
