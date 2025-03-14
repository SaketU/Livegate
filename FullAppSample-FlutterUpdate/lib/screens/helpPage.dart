import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
   @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Display Mode',style: GoogleFonts.interTight(color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.bold, fontSize: screenHeight*0.0248),),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, size: 30, color: Theme.of(context).colorScheme.tertiary,),
          padding: EdgeInsets.only(right: 7, bottom: 7), // Remove default padding
          constraints: BoxConstraints(), // Removes size constraints
        ),
      ),
    );
  }
}