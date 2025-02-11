import 'package:flutter/material.dart';

class  MySuggest extends StatefulWidget{
  final String label;

  MySuggest({required this.label});
  @override
  _MySuggestPageState createState() => _MySuggestPageState();
}

class _MySuggestPageState extends State<MySuggest> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(child: Text(widget.label, style: TextStyle(fontSize: 17)),
        ),
      ),
    );
  }
}