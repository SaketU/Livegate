import 'package:flutter/cupertino.dart';
import 'package:fullapp/models/chatUsersModel.dart';
import 'package:fullapp/widgets/conversationList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
//code
class RequestsPage extends StatefulWidget {
  final VoidCallback showChatPage;
  const RequestsPage({Key? key, required this.showChatPage}) : super(key: key);
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<RequestsPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Ryan Parker", messageText: "Hey man! How's it going?", profileImage: 'https://image.shutterstock.com/mosaic_250/2780032/1667439913/stock-photo-headshot-portrait-of-smiling-millennial-male-employee-talk-on-video-call-or-web-conference-in-1667439913.jpg', time: "21 Jan"),
    ChatUsers(name: "Jane Wilson", messageText: "Hey there", profileImage: 'https://images.unsplash.com/photo-1504439904031-93ded9f93e4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8NXx8fGVufDB8fHx8&w=1000&q=80', time: "15 Jan"),
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          leadingWidth: 140, // Adjust width to fit the icon and text
          leading: Row(
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
                padding: EdgeInsets.only(left: 10), // Adjust left padding if needed
                constraints: BoxConstraints(), // Removes default constraints
              ),
              Text(
                "Chats",
                style: GoogleFonts.interTight(
                  fontSize: screenHeight*0.035, // Adjust size as needed
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                  padding: EdgeInsets.only(left: 8,right: 11,top: 2,bottom: 2),
                  height: screenHeight*0.035,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFFFD80E),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add,size: screenHeight*0.024, color: Colors.black,),
                      SizedBox(width: 2,),
                      Text("New",style: GoogleFonts.interTight(fontSize: screenHeight*0.017,fontWeight: FontWeight.bold, color: Colors.black),),
                    ],
                  ),
                ),
            ),

              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  padding: EdgeInsets.only(left: 8,right: 11,top: 2,bottom: 2),
                  height: screenHeight*0.035,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.edit,size: screenHeight*0.018,),
                      SizedBox(width: 2,),
                      Text("Edit",style: GoogleFonts.interTight(fontSize: screenHeight*0.017,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
          ],
        ), 


      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, top: 5, right: 16),
              child: Container(
                width: double.infinity,
                height: screenHeight*0.047,
                child: TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: GoogleFonts.interTight(color: Colors.grey.shade600),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(10), // Adjust padding as needed
                      child: SizedBox(
                        width: 20,  // Adjust the width to fit well
                        height: 20,  // Adjust the height
                        child: SvgPicture.asset(
                          'assets/search-icon.svg',
                          colorFilter: ColorFilter.mode(
                            Colors.grey.shade600,  
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),//Icon(Icons.search,color: Colors.grey.shade600,size: 25,),
                    filled: true,
                    fillColor: Theme.of(context).brightness == Brightness.dark?
                    Color(0Xff242525) :Colors.black12,
                    contentPadding: EdgeInsets.only(top: 3, bottom: 3, left: 1),
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
            ),
      
            Padding(
                padding: EdgeInsets.only(top: 19, right: 16, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: widget.showChatPage,
                    child: 
                    Text("Messages",style: GoogleFonts.interTight(fontSize: screenHeight*0.018,fontWeight: FontWeight.w600, color:  Theme.of(context).colorScheme.onTertiary),)),
                    Text("Requests",style: GoogleFonts.interTight(fontSize: screenHeight*0.020,fontWeight: FontWeight.bold, color:  Theme.of(context).colorScheme.tertiary),),
                ],
              ),
            ),
      
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: screenHeight*0.0189,),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ConversationList(
                  name: chatUsers[index].name, messageText: chatUsers[index].messageText, time: chatUsers[index].time, profileImage: chatUsers[index].profileImage, isMessageRead: (index == 0 || index == 1)?true:false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


//paste chatPage code once responsive and just change this line
/*
body: Padding(
              padding: EdgeInsets.only(top: 19, right: 16, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                GestureDetector(
                onTap: widget.showChatPage,
                child:
                  Text("Messages",style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.w600, color:  Theme.of(context).colorScheme.onTertiary),),
                ),
                    Text("Requests",style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.w600, color:  Theme.of(context).colorScheme.tertiary),),
                ],
              ),
            ),
            */