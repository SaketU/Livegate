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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullapp/widgets/friendsBottomSheet.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LiveRoomPage extends StatefulWidget {
  final String team1;
  final String team2;
  final String gameId;

  LiveRoomPage({required this.team1, required this.team2, required this.gameId});

  @override
  _LiveRoomPageState createState() => _LiveRoomPageState();
}

class _LiveRoomPageState extends State<LiveRoomPage> {
  TextEditingController _controller = TextEditingController();
  bool _isTyping = false;
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
    RoomMessage(
        name: '@John_DJ',
        profileImage:
            'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Ohhh that was good",
        messageType: "sender",
        selected: true),
    RoomMessage(
        name: '@Max_10',
        profileImage:
            'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
        messageContent: "Nice shot",
        messageType: "receiver",
        selected: true),
  ];

  Future<void> sendMessage(String gameId, String messageText) async {
  final url = Uri.parse('http://localhost:8000/nba-message');

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "gameId": gameId,
      "message": messageText
    }),
  );

  if (response.statusCode == 200) {

    print("Message sent successfully");
  } else {

    print("Error sending message: ${response.body}");
  }
}

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTyping = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.back,
                  size: 30,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, right: 5),
                child: Row(
                      children: [
                        Text(
                          widget.team1,
                          style: GoogleFonts.interTight(
                            fontSize: screenHeight * 0.018,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Text(
                      ' vs ',
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                        Text(
                      widget.team2,
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                      ],
                    ),
              ),
              Spacer(),
              
              Padding(padding: EdgeInsets.only(right: 18),
              child: GestureDetector(
                child: 
                  SvgPicture.asset(
                    'assets/report.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.tertiary,  
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: GestureDetector(
                  onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => FriendsBottomSheet(),
                          );
                        },
                  child: 
                    SvgPicture.asset(
                      'assets/share.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.tertiary, 
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          // Chat messages (Scrollable List)
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              reverse: true, // Scroll from bottom to top
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero, // Ensure no extra padding
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index) {
                var message = messages[index];
                return buildMessage(message, index);
              },
            ),
          ),

          // Input Field Section
          Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Color(0Xff242525)
                : Colors.white,
            child: SafeArea(
              top: false,
              bottom: true,
              child: Container(
                height: screenHeight * 0.053,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 6),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0Xff242525)
                    : Colors.white,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 15),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
                      maxRadius: screenHeight * 0.020,
                    ),
                    SizedBox(width: 13),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        cursorColor: Theme.of(context).colorScheme.tertiary,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 11, left: 12),
                          suffixIconConstraints: BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: SvgPicture.asset(
                              'assets/stickers.svg',
                              width: screenWidth * 0.025,
                              height: screenHeight * 0.025,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.tertiary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.onPrimary,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 13),
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: GestureDetector(
                        onTap: _isTyping
                          ? () async {
                              // Retrieve and trim the text from the TextField
                              String messageText = _controller.text.trim();
                              if (messageText.isNotEmpty) {
                                RoomMessage newMessage = RoomMessage(
                                  name: '@YourName',
                                  profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
                                  messageContent: messageText,
                                  messageType: "sender",
                                  selected: true,
                                );
                                setState(() {
                                  messages.insert(0, newMessage);
                                });
                                await sendMessage(widget.gameId, messageText);
                                _controller.clear();
                              }
                            }
                          : null,
                        child: Container(
                          height: screenHeight * 0.040,
                          width: screenHeight * 0.040,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isTyping
                                ? ( Colors.black) //color when typed
                                : Theme.of(context).brightness == Brightness.dark
                                ?Colors.grey.shade800 : Colors.grey[350], //color when no typed dark : light
                          ),
                          child: Icon(
                            Icons.send,
                            color: _isTyping
                                ? (Colors.white) //color when typed
                                : Theme.of(context).brightness == Brightness.dark
                                    ?Colors.white60 : Colors.white70, //color when no typed dark : light
                            size: screenHeight * 0.020,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Message Bubble Widget
  Widget buildMessage(RoomMessage message, int index) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: Align(
        alignment: (messages[index].messageType == "receiver"
            ? Alignment.centerLeft
            : Alignment.centerRight),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            CircleAvatar(
                    backgroundImage: NetworkImage(messages[index].profileImage),
                    maxRadius: screenHeight*0.020,
                  ),
            SizedBox(width: screenWidth*0.008),
            // Name and Message Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Name
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return UsersProfilePage();
                      }));// Navigate to User Profile
                    },
                    child: Text(
                      messages[index].name,
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight*0.018,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  // Message Content
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: (messages[index].messageType == "receiver" //Color of the text containers
                          ? Theme.of(context).colorScheme.primary //other users texts
                          : Theme.of(context).brightness == Brightness.dark? //your texts
                          Colors.blue: Theme.of(context).colorScheme.secondary),//dark mode : light mode
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight*0.0095, horizontal: 17),
                    child: Text(
                      messages[index].messageContent,
                      style: GoogleFonts.interTight(
                        fontSize: screenHeight*0.018,
                        color: messages[index].messageType == "receiver" //color of the letters 
                            ? Theme.of(context).colorScheme.tertiary //other users texts
                            : Theme.of(context).colorScheme.onSecondary, //your texts
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



  



//old app bar
/*AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 18, left: 18),
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
                    style: GoogleFonts.interTight(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary)),
                SizedBox(width: 4),
                Text('1 hr',
                    style: GoogleFonts.interTight(
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
      */

      
/*
Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(top: 10,),
                      height: screenHeight*0.052,
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
                          SizedBox(width: 13,),
        
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
                            padding: const EdgeInsets.only(left: 33, right: 18),
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
        */