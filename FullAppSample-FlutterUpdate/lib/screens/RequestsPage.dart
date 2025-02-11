import 'package:flutter/cupertino.dart';
import 'package:fullapp/models/chatUsersModel.dart';
import 'package:fullapp/widgets/conversationList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestsPage extends StatefulWidget {
  final VoidCallback showChatPage;
  const RequestsPage({Key? key, required this.showChatPage}) : super(key: key);
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<RequestsPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "John Murphy", messageText: "That was great, thanks", profileImage: 'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg', time: "Now"),
    ChatUsers(name: "Luis Jose", messageText: "Yeah", profileImage: 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80', time: "2:30pm"),
    ChatUsers(name: "Emma Hall", messageText: "Thanks", profileImage: 'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-3763188.jpg&fm=jpg', time: "12:50pm"),
    ChatUsers(name: "Chris Johnson", messageText: "Ok, see you soon", profileImage: 'https://media.istockphoto.com/id/1300972574/photo/millennial-male-team-leader-organize-virtual-workshop-with-employees-online.jpg?b=1&s=170667a&w=0&k=20&c=96pCQon1xF3_onEkkckNg4cC9SCbshMvx0CfKl2ZiYs=', time: "Yesterday"),
    ChatUsers(name: "Alejandra Vasquez", messageText: "I will try to look for it", profileImage: 'https://images.unsplash.com/photo-1604072366595-e75dc92d6bdc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZSUyMHBob3RvfGVufDB8fDB8fA%3D%3D&w=1000&q=80', time: "Yesterday"),
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.back, size: 30,),
                          padding: EdgeInsets.only(right: 7, bottom: 7), // Remove default padding
                          constraints: BoxConstraints(), // Removes size constraints
                        ),

                        Text("Chats",style: GoogleFonts.inter(fontSize: 32,fontWeight: FontWeight.bold),),
                      ],
                    ),

                    //New chat
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.yellow[700],
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.add,size: 20, color: Colors.black,),
                              SizedBox(width: 2,),
                              Text("New",style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black),),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Container(
                          padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.edit,size: 15,),
                              SizedBox(width: 2,),
                              Text("Edit",style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 16,right: 16),
              child: Container(
                width: double.infinity,
                height: 40,
                child: TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: GoogleFonts.inter(color: Colors.grey.shade600),
                    prefixIcon: Icon(Icons.search,color: Colors.grey.shade600,size: 25,),
                    filled: true,
                    fillColor: Colors.black12,
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
                  Text("Messages",style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.w600, color:  Theme.of(context).colorScheme.onTertiary),),
                ),
                    Text("Requests",style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.w600, color:  Theme.of(context).colorScheme.tertiary),),
                ],
              ),
            ),

            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
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