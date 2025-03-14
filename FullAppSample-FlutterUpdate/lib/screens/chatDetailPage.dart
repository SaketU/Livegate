import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:focused_menu/modals.dart';
import 'package:fullapp/models/chatMessageModel.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/screens/chatDocumentsPage.dart';
import 'package:fullapp/screens/chatInfoPage.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:fullapp/widgets/searchTags.dart';
import 'package:fullapp/models/chatMessageModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatDetailPage extends StatefulWidget{
  final String name;
  final String profileImage;

  ChatDetailPage({required this.name, required this.profileImage});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController _controller = TextEditingController();
  bool _isTyping = false;
  bool saved = false;

  List<ChatMessage> messages = [

    ChatMessage(messageContent: "We'll see ", messageType: "receiver", time: '11:46 PM', selected: true),
    ChatMessage(messageContent: "Agree", messageType: "sender", time: '11:46 PM', selected: true),
    ChatMessage(messageContent: "and the offense couldn't move the ball", messageType: "receiver", time: '11:45 PM', selected: true),
    ChatMessage(messageContent: "The defense was struggling", messageType: "receiver", time: '11:45 PM', selected: true),
    ChatMessage(messageContent: "They need to make some adjustments", messageType: "receiver", time: '11:45 PM', selected: true),
    ChatMessage(messageContent: "Hopefully better", messageType: "sender", time: '11:44 PM', selected: true),
    ChatMessage(messageContent: "But we'll see how it goes on the next one", messageType: "sender", time: '11:44 PM', selected: true),
    ChatMessage(messageContent: "True", messageType: "receiver", time: '11:43 PM', selected: true),
    ChatMessage(messageContent: "At that point of the game you have nothing to loose", messageType: "sender", time: '11:43 PM', selected: true),
    ChatMessage(messageContent: "I feel like they should have gone for it on fourth down", messageType: "sender", time: '11:43 PM', selected: true),
    ChatMessage(messageContent: "yeah, they took it down to the wire", messageType: "receiver", time: '11:42 PM', selected: false),
    ChatMessage(messageContent: "Hey, yeah it was really good", messageType: "sender", time: '11:42 PM', selected: true),
    ChatMessage(messageContent: "Did you catch the game last night?", messageType: "receiver", time: '11:41 PM', selected: false),
    ChatMessage(messageContent: "Hey", messageType: "receiver", time: '11:41 PM', selected: true),
  ];

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
                padding: const EdgeInsets.only(left: 3, right: 10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.profileImage),
                  maxRadius: screenHeight*0.025,
                ),
              ),
              Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ChatInfoPage();
                          }));
                        },
                        child:
                        Text(widget.name,style: GoogleFonts.interTight(
                              fontSize: screenHeight*0.0185,
                              fontWeight: FontWeight.bold,),),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Container(
                      width: screenHeight*0.011,
                      height: screenHeight*0.011,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFD80E),
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.only(right: screenHeight*0.011),
                    ),
                      ),

                  Spacer(),
                  
                  Padding(padding: EdgeInsets.only(right: 26),
                  child: GestureDetector(
                    child: 
                      SvgPicture.asset(
                        'assets/facetime.svg',
                        height: screenHeight*0.028,
                        width: screenWidth*0.035,
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

                      },
                      child: 
                        SvgPicture.asset(
                          'assets/phone.svg',
                          height: screenHeight*0.028,
                          width: screenWidth*0.035,
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
      height: screenHeight * 0.052,
      width: double.infinity,
      padding: EdgeInsets.only(top: 6, bottom: 6),
      color: Theme.of(context).brightness == Brightness.dark
          ? Color(0Xff242525)
          : Colors.white,
      child: Row(
        children: <Widget>[
          SizedBox(width: 15),

          // Profile Image
          SvgPicture.asset(
            'assets/camera.svg',
            height: screenHeight*0.028,
            width: screenWidth*0.034,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.tertiary,
              BlendMode.srcIn,
            ),
          ),

          SizedBox(width: 13),

          // Input Field
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

          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {
                  if (_controller.text.trim().isNotEmpty) {
                    print("Message Sent: ${_controller.text}");
                    _controller.clear(); // Clear text field
                  }
                },
                child: Center(
                  child: Container(
                    height: screenHeight * 0.040,
                    width: screenHeight * 0.040,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Theme.of(context).colorScheme.tertiary,
                    ),
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Theme.of(context).colorScheme.onPrimary,
                      size: screenHeight * 0.020,
                    ),
                  ),
                ),
              ),
            )
          else ...[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return ChatInfoPage();
                  }));
                },
                child: SvgPicture.asset(
                  'assets/photos.svg',
                  height: screenHeight*0.032,
                  width: screenWidth*0.032,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.tertiary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: GestureDetector(
                child: SvgPicture.asset(
                  'assets/mic.svg',
                  height: screenHeight*0.0284,
                  width: screenWidth*0.0187,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.tertiary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
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
  Widget buildMessage(ChatMessage message, int index) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return
      Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14,),
          child: Align(
            alignment: (messages[index].messageType == "receiver"
                ? Alignment.centerLeft
                : Alignment.centerRight),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: (messages[index].messageType == "receiver"
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).brightness == Brightness.dark? //your texts
                    Colors.grey[800]: Theme.of(context).colorScheme.secondary),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: 17), //screenHeight*0.010, horizontal: screenWidth*0.05
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      messages[index].messageContent,
                      style: GoogleFonts.inter(
                        fontSize: screenHeight*0.018,
                        color: messages[index].messageType == "receiver"
                            ? Theme.of(context).colorScheme.tertiary
                            : Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  /*
                  SizedBox(width: 8),
                  Text(
                    messages[index].time,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                  */
                ],
              ),
            ),
          ),
      );
  }
}



/*
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
            alignment: Alignment.center,
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
                /*IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(CupertinoIcons.back),
                ),

                 */
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: NetworkImage('https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
                  maxRadius: 20,
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ChatInfoPage();
                          }));
                        },
                        child:
                        Text("John Murphy",style: GoogleFonts.interTight( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(width: 6,),
                      Container(
                        height: 9,
                        width: 9,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade700,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      //old online code
                      //SizedBox(height: 4,),
                      //Text("Online",style: TextStyle(color: Colors.grey.shade500, fontSize: 13),),

                    ],
                  ),
                ),

                //SearchTags
                IconButton(
                  onPressed: (){

                  },
                  icon: Transform(
                    transform: Matrix4.identity()..scale(1, 1.2), // Adjust width (x) and height (y) scaling
                    alignment: Alignment.center, // Keeps scaling centered
                    child: Icon(
                      CupertinoIcons.video_camera, // Your desired icon
                      size: 33, // Base size of the icon
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),

                //Chat Media
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ChatDocumentsPage();
                    }));
                  },
                  icon: Icon(CupertinoIcons.phone, color: Theme.of(context).colorScheme.tertiary,),
                ),



              ],
            ),
          ),
        ),
      ),




      body: Stack(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(bottom: 40),
            child:
            ListView.builder(
              itemCount: messages.length,
              reverse: true, // Scroll from bottom to top
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index){
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
                        padding: const EdgeInsets.only(left: 15.0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle camera icon tap
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            child: Icon(
                              CupertinoIcons.camera,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          cursorColor: Theme.of(context).colorScheme.tertiary,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 12, left: 12),
                            suffixIcon: Icon(
                              CupertinoIcons.square,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.onPrimary,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      if (_isTyping)
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: GestureDetector(
                            onTap: () {
                              // Handle send icon tap
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
                        )
                      else ...[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ChatInfoPage();
                            }));
                          },
                          child: Icon(
                            CupertinoIcons.photo_on_rectangle,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 12,)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ChatInfoPage();
                            }));
                          },
                          child: Icon(
                            CupertinoIcons.mic,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 15,)),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          )


        ],
      ),
    );
  }
  Widget buildMessage(ChatMessage message, int index) =>
      FocusedMenuHolder(
        menuItems: [
          FocusedMenuItem(
            title: Text('Tag'),
            trailingIcon: Icon(CupertinoIcons.bookmark),
            onPressed: () {
              setState(() {
                saved = true;
              });
            },
          ),
          FocusedMenuItem(
            title: Text('Forward'),
            trailingIcon: Icon(CupertinoIcons.paperplane),
            onPressed: () {},
          ),
          FocusedMenuItem(
            title: Text(
              'Delete',
              style: GoogleFonts.interTight(color: Colors.red),
            ),
            trailingIcon: Icon(
              CupertinoIcons.delete,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
        ],
        blurBackgroundColor: Colors.grey,
        openWithTap: false,
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.only(left: 14, right: 14, top: 7, bottom: 7),
          child: Align(
            alignment: (messages[index].messageType == "receiver"
                ? Alignment.centerLeft
                : Alignment.centerRight),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: (messages[index].messageType == "receiver"
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: 17),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      messages[index].messageContent,
                      style: GoogleFonts.interTight(
                        fontSize: 15,
                        color: messages[index].messageType == "receiver"
                            ? Theme.of(context).colorScheme.tertiary
                            : Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    messages[index].time,
                    style: GoogleFonts.interTight(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );





  Widget makeDismissible ({required Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.of(context).pop(),
    child: GestureDetector(onTap: () {}, child: child,),
  );

  //search tags builder
  Widget buildSheet() => makeDismissible(
    child: DraggableScrollableSheet(
      initialChildSize: 0.75,
      builder: (_, controller) =>
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 20),
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
                      prefixIcon: Icon(CupertinoIcons.search,color: Colors.grey.shade600,size: 25,),
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
*/







    /*
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 5),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(CupertinoIcons.back),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: NetworkImage('https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
                  maxRadius: 20,
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ChatInfoPage();
                          }));
                        },
                        child:
                        Text("John Murphy",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(width: 6,),
                      Container(
                        height: 9,
                        width: 9,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade700,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      //old online code
                      //SizedBox(height: 4,),
                      //Text("Online",style: TextStyle(color: Colors.grey.shade500, fontSize: 13),),

                    ],
                  ),
                ),

                //SearchTags
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => buildSheet(),

                      /*
                    {

                      return SizedBox(
                        height: 1200,
                        child: IconButton(
                          alignment: Alignment.topLeft,
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.back),
                        ),
                      );
                    }

                         */



                    );
                  },
                  icon: Icon(CupertinoIcons.search),
                ),

                //Chat Media
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ChatDocumentsPage();
                    }));
                  },
                  icon: Icon(Icons.menu),
                ),



              ],
            ),
          ),
        ),
      ),

      body: Stack(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(bottom: 60),
            child:
            ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10,bottom: 10),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index){
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
                    padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                            height: 30,
                            width: 30,

                            child: Icon(Icons.add, color: Colors.grey, size: 30,),
                          ),
                        ),
                        SizedBox(width: 15,),

                        Expanded(
                          child: TextField(
                            cursorColor: Theme.of(context).colorScheme.tertiary,

                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 12, left: 12),
                              hintText: "Write message...",
                              hintStyle: TextStyle(),
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
                        SizedBox(width: 15,),
                        FloatingActionButton(
                          onPressed: (){},
                          child: Icon(Icons.send,color: Colors.white,size: 18,),
                          backgroundColor: Colors.blue,
                          elevation: 0,
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
  Widget buildMessage(ChatMessage message, int index) =>
      FocusedMenuHolder(
        menuItems: [
          FocusedMenuItem(title: Text('Tag'), trailingIcon: Icon(CupertinoIcons.bookmark) ,onPressed: () {
            setState(() {
              saved = true;
            });
          }),
          FocusedMenuItem(title: Text('Forward'), trailingIcon: Icon(CupertinoIcons.paperplane) ,onPressed: () {}),
          FocusedMenuItem(title: Text('Delete', style: TextStyle(color: Colors.red),), trailingIcon: Icon(CupertinoIcons.delete, color: Colors.red,) ,onPressed: () {}),
        ],
        blurBackgroundColor: Colors.grey,
        openWithTap: false,
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
          child: Align(
            alignment: (messages[index].messageType == "receiver"?Alignment.centerLeft:Alignment.centerRight),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (messages[index].messageType == "receiver"?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.secondary),
                //Colors.black12:Colors.black26
              ),
              padding: EdgeInsets.all(16),
              child:
              Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
            ),
          ),
        ),
      );

  Widget makeDismissible ({required Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.of(context).pop(),
    child: GestureDetector(onTap: () {}, child: child,),
  );

  //search tags builder
  Widget buildSheet() => makeDismissible(
    child: DraggableScrollableSheet(
      initialChildSize: 0.75,
      builder: (_, controller) =>
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 20),
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
                      prefixIcon: Icon(CupertinoIcons.search,color: Colors.grey.shade600,size: 25,),
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
     */





    /*
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white10,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 5),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(CupertinoIcons.back),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                  maxRadius: 20,
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ChatInfoPage();
                          }));
                        },
                        child:
                        Text("John Murphy",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(width: 6,),
                      Container(
                        height: 9,
                        width: 9,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade700,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      //old online code
                      //SizedBox(height: 4,),
                      //Text("Online",style: TextStyle(color: Colors.grey.shade500, fontSize: 13),),

                    ],
                  ),
                ),
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ChatDocumentsPage();
                    }));
                  },
                  icon: Icon(Icons.menu),
                ),

              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              var message = messages[index];

              return buildMessage(message, index);
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white10,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,

                      child: Icon(Icons.add, color: Colors.grey, size: 30,),
                    ),
                  ),
                  SizedBox(width: 15,),

                  Expanded(
                    child: TextField(

                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 12, left: 12),
                        hintText: "Write message...",
                        hintStyle: TextStyle(),
                        filled: true,
                        fillColor: Colors.black26,
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
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){},
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget buildMessage(ChatMessage message, int index) =>
      FocusedMenuHolder(
        menuItems: [
          FocusedMenuItem(title: Text('save'), trailingIcon: Icon(CupertinoIcons.bookmark) ,onPressed: () {
            setState(() {
              saved = true;
            });
          }),
          FocusedMenuItem(title: Text('Make Post'), trailingIcon: Icon(CupertinoIcons.paperplane) ,onPressed: () {}),
          FocusedMenuItem(title: Text('Delete', style: TextStyle(color: Colors.red),), trailingIcon: Icon(CupertinoIcons.delete, color: Colors.red,) ,onPressed: () {}),
        ],
        blurBackgroundColor: Colors.blueGrey.shade900,
        openWithTap: false,
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
          child: Align(
            alignment: (messages[index].messageType == "receiver"?Alignment.centerLeft:Alignment.centerRight),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (messages[index].messageType == "receiver"?Colors.black12:Colors.black26),
              ),
              padding: EdgeInsets.all(16),
              child:
              Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
            ),
          ),
        ),
      );
}

     */
