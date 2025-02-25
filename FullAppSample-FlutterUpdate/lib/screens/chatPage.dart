import 'package:flutter/cupertino.dart';
import 'package:fullapp/models/chatUsersModel.dart';
import 'package:fullapp/widgets/conversationList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
//code
class ChatPage extends StatefulWidget {
  final VoidCallback showRequestsPage;
  const ChatPage({Key? key, required this.showRequestsPage}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "John Murphy", messageText: "That was great, thanks", profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg', time: "now"),
    ChatUsers(name: "Luis Jose", messageText: "Yeah", profileImage: 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80', time: "2:30pm"),
    ChatUsers(name: "Emma Hall", messageText: "Thanks", profileImage: 'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-3763188.jpg&fm=jpg', time: "12:50pm"),
    ChatUsers(name: "Chris Johnson", messageText: "Ok, see you soon", profileImage: 'https://media.istockphoto.com/id/1300972574/photo/millennial-male-team-leader-organize-virtual-workshop-with-employees-online.jpg?b=1&s=170667a&w=0&k=20&c=96pCQon1xF3_onEkkckNg4cC9SCbshMvx0CfKl2ZiYs=', time: "yesterday"),
    ChatUsers(name: "Alejandra Vasquez", messageText: "I will try to look for it so whenever you can let me know so I can look somewhere else", profileImage: 'https://images.unsplash.com/photo-1604072366595-e75dc92d6bdc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZSUyMHBob3RvfGVufDB8fDB8fA%3D%3D&w=1000&q=80', time: "yesterday"),
    ChatUsers(name: "Jack Jones", messageText: "Sounds good", profileImage: 'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc=', time: "20 Jan"),
    ChatUsers(name: "Victoria Fox", messageText: "OK", profileImage: 'https://images.unsplash.com/photo-1591361796603-01599a42e701?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE0fHx8ZW58MHx8fHw%3D&w=1000&q=80', time: "19 Jan"),
    ChatUsers(name: "James Watt", messageText: "Alr", profileImage: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg', time: "19 Jan"),
    ChatUsers(name: "Blake Price", messageText: "I will see", profileImage: 'https://st4.depositphotos.com/4157265/39988/i/450/depositphotos_399882790-stock-photo-profile-picture-of-smiling-attractive.jpg', time: "18 Jan"),
    ChatUsers(name: "Juan Lopez", messageText: "I'll try to call", profileImage: 'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg', time: "17 Jan"),
    ChatUsers(name: "Ryan Parker", messageText: "Looks good", profileImage: 'https://image.shutterstock.com/mosaic_250/2780032/1667439913/stock-photo-headshot-portrait-of-smiling-millennial-male-employee-talk-on-video-call-or-web-conference-in-1667439913.jpg', time: "16 Jan"),
    ChatUsers(name: "Jane Wilson", messageText: "fine", profileImage: 'https://images.unsplash.com/photo-1504439904031-93ded9f93e4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8NXx8fGVufDB8fHx8&w=1000&q=80', time: "15 Jan"),
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
                  Text("Messages",style: GoogleFonts.interTight(fontSize: screenHeight*0.020,fontWeight: FontWeight.bold, color:  Theme.of(context).colorScheme.tertiary),),
                  GestureDetector(
                    onTap: widget.showRequestsPage,
                    child:
                  Text("Requests",style: GoogleFonts.interTight(fontSize: screenHeight*0.018,fontWeight: FontWeight.w600, color:  Theme.of(context).colorScheme.onTertiary),),
                  ),
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
                  name: chatUsers[index].name, messageText: chatUsers[index].messageText, time: chatUsers[index].time, profileImage: chatUsers[index].profileImage, isMessageRead: (index == 0 || index == 3)?true:false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}