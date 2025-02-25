import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// A dismissible and draggable bottom sheet
class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
        initialChildSize: 0.75, // Default open height (75% of screen)
        minChildSize: 0.4, // Allows smaller drag size
        maxChildSize: 0.9, // Allows full-screen expansion
        expand: false, // Prevents forced expansion
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark? 
            Color(0Xff242525) : Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          ),
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 20),
          child: ListView(
            controller: controller,
            children: [
              // Search Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                width: double.infinity,
                height: 35,
                child: TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: GoogleFonts.interTight(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: Colors.grey.shade600,
                      size: 25,
                    ),
                    filled: true,
                    fillColor: Colors.black12,
                    contentPadding: const EdgeInsets.all(3),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Makes the bottom sheet dismissible when tapping outside
  Widget makeDismissible({required BuildContext context, required Widget child}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque, // Ensures taps are detected outside
        onTap: () => Navigator.of(context).pop(), // Dismiss when tapping outside
        child: Stack(
          children: [
            GestureDetector( // Prevents dismiss when interacting inside the sheet
              onTap: () {},
              child: child,
            ),
          ],
        ),
      );
}
