import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:fullapp/models/roomChatModel.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:fullapp/screens/chatDocumentsPage.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/screens/usersProfilePage.dart';
import 'package:fullapp/widgets/liveList.dart';
import 'package:fullapp/models/Rooms.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class LiveRoomPage extends StatefulWidget {

  @override
  _LiveRoomPageState createState() => _LiveRoomPageState();
}

class _LiveRoomPageState extends State<LiveRoomPage> {
  bool saved = false;

  List<RoomMessage> messages = [
    RoomMessage(name: '@Letsgo',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Good play",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@James_L',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Nice",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@LV',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Yeah, that play was a beauty",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@King_M',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "They just need to keep it up on defense",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@JonasTk',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Agree",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@Johnny25',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Come on, let's goooo",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@LewisB',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Ufff",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@John_DJ',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Ohhh that was good",
        messageType: "sender",
        selected: true),
    RoomMessage(name: '@Max_10',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Nice shot",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@Letsgo',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Good play",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@James_L',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Nice",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@LV',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Yeah, that play was a beauty",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@King_M',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "They just need to keep it up on defense",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@JonasTk',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Agree",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@Johnny25',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Come on, let's goooo",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@LewisB',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Ufff",
        messageType: "receiver",
        selected: true),
    RoomMessage(name: '@John_DJ',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Ohhh that was good",
        messageType: "sender",
        selected: true),
    RoomMessage(name: '@Max_10',
        profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Nice shot",
        messageType: "receiver",
        selected: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 5, left: 10),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(CupertinoIcons.back, size: 30,),
                  padding: EdgeInsets.only(right: 7, bottom: 7), // Remove default padding
                  constraints: BoxConstraints(), // Removes size constraints
                ),
                SizedBox(width: 2),
                Text('Lakers vs Warriors',
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary)),
                SizedBox(width: 4),
                Text('1 hr',
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onTertiary)),
                SizedBox(width: 6),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        padding: EdgeInsets.only(bottom: 1),
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => buildSheet(),
                          );
                        },
                        icon: Icon(
                            CupertinoIcons.paperplane,
                            size: 24,
                            color: Theme.of(context).colorScheme.tertiary),
                        constraints: BoxConstraints(),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatDocumentsPage()));
                        },
                        icon: Icon(CupertinoIcons.exclamationmark_circle, size: 26,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: ListView.builder(
              itemCount: messages.length,
              reverse: true, // Scroll from bottom to top
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var message = messages[index];
                return buildMessage(message, index);
              },
            ),
          ),
          Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    height: 65,
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Container(
                            width: 37,
                            height: 37,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage('https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 23,),

                        Expanded(
                          child: TextField(
                            cursorColor: Theme.of(context).colorScheme.tertiary,

                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 12, left: 12),
                              suffixIcon: Icon(CupertinoIcons.square,color: Theme.of(context).colorScheme.tertiary,),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.onPrimary,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  borderSide: BorderSide(color: Colors.transparent)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                                borderSide: BorderSide(color: Colors.black26),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 23, right: 18),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return ProfilePage();
                              }));
                            },
                            child: Center(
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                                child: Icon(
                                  Icons.send,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]
          ),

        ],
      ),
    );
  }

  Widget buildMessage(RoomMessage message, int index) => FocusedMenuHolder(
    menuItems: [
      FocusedMenuItem(
          title: Text('Tag'),
          trailingIcon: Icon(CupertinoIcons.bookmark),
          onPressed: () {
            setState(() {
              saved = true;
            });
          }),
      FocusedMenuItem(
          title: Text('Forward'),
          trailingIcon: Icon(CupertinoIcons.paperplane),
          onPressed: () {}),
      FocusedMenuItem(
          title: Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
          trailingIcon: Icon(
            CupertinoIcons.delete,
            color: Colors.red,
          ),
          onPressed: () {}),
    ],
    blurBackgroundColor: Colors.grey,
    openWithTap: false,
    onPressed: () {},
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 14),
      child: Align(
        alignment: (messages[index].messageType == "receiver"
            ? Alignment.centerLeft
            : Alignment.centerRight),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            Container(
              width: 37,
              height: 37,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(messages[index].profileImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 7),
            // Name and Message Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Name
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return UsersProfilePage();
                      }));
                    },
                    child: Text(
                      messages[index].name,
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                  SizedBox(height: 5),
                  // Message Content
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: (messages[index].messageType == "receiver"
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 17),
                    child: Text(
                      messages[index].messageContent,
                      style: TextStyle(
                        fontSize: 15,
                        color: messages[index].messageType == "receiver"
                            ? Theme.of(context).colorScheme.tertiary
                            : Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );



  Widget makeDismissible({required Widget child}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(onTap: () {}, child: child,),
      );

  Widget buildSheet() =>
      makeDismissible(
        child: DraggableScrollableSheet(
          initialChildSize: 0.75,
          builder: (_, controller) =>
              Container(
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .tertiaryContainer,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                padding: EdgeInsets.only(
                    top: 15, left: 10, right: 10, bottom: 20),
                child: ListView(
                  controller: controller,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      width: double.infinity,
                      height: 35,
                      child: TextField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(
                            CupertinoIcons.search, color: Colors.grey.shade600,
                            size: 25,),
                          filled: true,
                          fillColor: Colors.black12,
                          contentPadding: EdgeInsets.all(3),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black12),
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