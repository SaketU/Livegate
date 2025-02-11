import 'package:flutter/material.dart';
import 'package:fullapp/screens/RequestsPage.dart';
import 'package:fullapp/screens/chatPage.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {

  bool showChatPage = true;

  void changeScreens() {
    setState(() {
      showChatPage  = !showChatPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showChatPage) {
      return ChatPage(showRequestsPage: changeScreens);
    } else {
      return RequestsPage(showChatPage: changeScreens);
    }
  }
}