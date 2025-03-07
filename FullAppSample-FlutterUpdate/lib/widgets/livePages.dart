import 'package:flutter/material.dart';
import 'package:fullapp/screens/LivesPage.dart';
import 'package:fullapp/screens/upcomingPage.dart';
import 'package:fullapp/screens/moreOptions.dart';

class LivePages extends StatefulWidget {
  const LivePages({Key? key}) : super(key: key);

  @override
  _LivePagesState createState() => _LivePagesState();
}

class _LivePagesState extends State<LivePages> {
  int currentScreenIndex = 0; // 0: ChatPage, 1: RequestsPage, 2: AnotherPage

  void changeScreens(int newIndex) {
    setState(() {
      currentScreenIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (currentScreenIndex) {
      case 0:
        return LivesPage(showUpcomingPage: () => changeScreens(1), showMoreOptions: () => changeScreens(2));
      case 1:
        return UpcomingPage(showLivesPage: () => changeScreens(0), showMoreOptions: () => changeScreens(2));
      case 2:
        return MoreOptions(showLivesPage: () => changeScreens(0), showUpcomingPage: () => changeScreens(1));
      default:
        return LivesPage(showUpcomingPage: () => changeScreens(1), showMoreOptions: () => changeScreens(2));
    }
  }
}

/*
return ChatPage(showRequestsPage: () => changeScreens(1), showAnotherPage: () => changeScreens(2));
      case 1:
        return RequestsPage(showChatPage: () => changeScreens(0), showAnotherPage: () => changeScreens(2));
      case 2:
        return AnotherPage(showChatPage: () => changeScreens(0), showRequestsPage: () => changeScreens(1));
      default:
        return ChatPage(showRequestsPage: () => changeScreens(1), showAnotherPage: () => changeScreens(2));
 */