import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLiveList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.dark 
          ? Colors.grey[800]! 
          : Colors.grey[300]!,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[100]!
          : Colors.grey[50]!,
      child: Container(
        margin: EdgeInsets.only(bottom: 22),
        height: screenHeight * 0.105,
        child: Stack(
          children: [
            // League name shimmer
            Positioned(
              top: 15,
              left: 15,
              child: Container(
                width: 30,
                height: screenHeight * 0.017,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            // Home team name shimmer
            Positioned(
              top: 40,
              left: 16,
              child: Container(
                width: 120,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            // Status shimmer
            Positioned(
              left: 15,
              top: 65,
              child: Container(
                width: 60,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            Positioned(
              right: 25,
              top: 15,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 