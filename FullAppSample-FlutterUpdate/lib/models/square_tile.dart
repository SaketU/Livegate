import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SquareTile extends StatelessWidget{
  final String imagePath;
  const SquareTile({
  super.key,
  required this.imagePath
  });


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight*0.104,
      width: screenWidth*0.22,
      padding: EdgeInsets.symmetric(horizontal: screenWidth*0.051, vertical: screenHeight*0.023),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primaryContainer,),
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Image.asset(
          imagePath,
      height: 35,
      ),
    );
  }
}
