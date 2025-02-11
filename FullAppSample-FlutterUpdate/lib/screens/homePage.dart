import 'package:flutter/cupertino.dart';
import 'package:fullapp/screens/LivesPage.dart';
import 'package:fullapp/screens/chatPage.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/screens/exProfilePage.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/screens/sourcePage.dart';
import 'package:fullapp/screens/upcomingPage.dart';
import 'package:fullapp/widgets/chats.dart';

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List <Widget> pages = [ChatsPage(), ProfilePage()];

  int selectedIndex = 1;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        selectedItemColor: Theme.of(context).colorScheme.tertiary,
        unselectedItemColor: Colors.grey.shade500,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2_fill, size: 31,), //25
            label: 'feed'
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.paperplane_fill, size: 40,),
            label: 'main'
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled, size: 30,),
            label: 'chats'
          ),
        ],
      ),
    );
  }
}


















