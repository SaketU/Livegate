import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/models/groupMemberModel.dart';
import 'package:fullapp/screens/chatDocumentsPage.dart';
import 'package:fullapp/screens/chatPage.dart';
import 'package:fullapp/screens/profilePage.dart';
import 'package:fullapp/screens/settings.dart';
import 'package:fullapp/widgets/membersList.dart';
import 'package:fullapp/widgets/chats.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatInfoPage extends StatefulWidget {
  @override
  _ChatInfoPageState createState() => _ChatInfoPageState();
}

class _ChatInfoPageState extends State<ChatInfoPage> {

  List <GroupMember> members = [
    GroupMember(name: 'member 1', profileImage:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
    GroupMember(name: 'member 2', profileImage:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png' ),
    GroupMember(name: 'member 3', profileImage:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png' ),
    GroupMember(name: 'member 4', profileImage:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png' ),
    GroupMember(name: 'member 5', profileImage:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png' ),
    GroupMember(name: 'member 6', profileImage:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png' ),
    GroupMember(name: 'member 7', profileImage:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png' ),
    GroupMember(name: 'member 8', profileImage:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png' ),
    GroupMember(name: 'member 9', profileImage:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png' ),
  ];

  final profileImage =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
  ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, size: 30,color: Theme.of(context).colorScheme.tertiary),
          padding: EdgeInsets.only(right: 7, bottom: 7), // Remove default padding
          constraints: BoxConstraints(), // Removes size constraints
        ),

        actions: [
          Padding(padding: EdgeInsets.only(left: 16,right: 14),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //search chat
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ChatDocumentsPage();
                    }));
                  },
                  icon: Icon(CupertinoIcons.search, size: 26,color: Theme.of(context).colorScheme.tertiary),
                ),

                //Chat Media
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ChatDocumentsPage();
                    }));
                  },
                  icon: Icon(Icons.photo_library_outlined, color: Theme.of(context).colorScheme.tertiary,),//photo_library_outlined
                ),
              ],
            ),
          ),
        ],
      ),


      //Group picture and name
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image:
                        NetworkImage(profileImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 22, right: 8, left: 8, bottom: 30),
                      child: Text('Name of Group', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),


                    //Group options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {

                              },
                              child: Icon(CupertinoIcons.pencil),
                            ),
                            SizedBox(height: 15,),
                            Text('Edit', style: GoogleFonts.inter(fontSize: 12)),
                          ],
                        ),
                        SizedBox(width: 41,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {

                              },
                              child: Icon(CupertinoIcons.person),
                            ),
                            SizedBox(height: 15,),
                            Text('9 members', style: GoogleFonts.inter(fontSize: 12)),
                          ],
                        ),
                        SizedBox(width: 41,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {

                              },
                              child: Icon(CupertinoIcons.speaker_slash),
                            ),
                            SizedBox(height: 15,),
                            Text('Mute', style: GoogleFonts.inter(fontSize: 12)),
                          ],
                        ),
                        SizedBox(width: 41,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Handle tap action
                              },
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0), // Flip horizontally
                                child: Icon(CupertinoIcons.square_arrow_left),
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Leave',
                              style: GoogleFonts.inter(fontSize: 12),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              ],
            ),

            //add a member to the group
            GestureDetector(
              onTap: () {

              },
              child: Container(
                padding: EdgeInsets.only(left: 16,right: 16,top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Align the row's content to the left
                  children: [
                    Container(
                      width: 50, // Circle size
                      height: 50, // Circle size
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent, // Transparent background
                        border: Border.all(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .tertiary,
                          width: 2, // Border width
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 22,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .tertiary,// Icon size
                      ),
                    ),
                    SizedBox(width: 16), // Add some spacing between the circle and text
                    Text(
                      'Add members',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //group members list
            ListView.builder(
              itemCount: members.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 8),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return MembersList(
                  name: members[index].name, profileImage: members[index].profileImage,
                );},
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
          ],
        ),
      ),
    );
  }
}


    /*
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back,),
        ),
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image:
                        NetworkImage(profileImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 8, left: 8, bottom: 5),
                      child: Text('Name of Group', style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Text("9 members", style: TextStyle(color: Colors.grey.shade500),),
                    ),

                    Padding(
                        padding: EdgeInsets.only(bottom: 10,)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return GroupProfilePage();
                        }));
                      },
                      child:
                      Container(
                        width: 350,
                        height: 60,
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.edit,size: 20,),
                            SizedBox(width: 10,),
                            Center(child: Text('Edit Group', style: TextStyle(fontSize: 17)),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Create Group Account button
                    //if already have an account, then go to account button
                    Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 10)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return GroupProfilePage();
                        }));
                      },
                      child:
                      Container(
                        width: 350,
                        height: 60,
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add,size: 20,),
                            SizedBox(width: 10,),
                            Center(child: Text('Mute', style: TextStyle(fontSize: 17)),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //any chat post suggestion to vote on tab
                    //where all members would vote to decide if chat is uploaded

                    Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 10)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return GroupProfilePage();
                        }));
                      },
                      child:
                      Container(
                        width: 350,
                        height: 60,
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(CupertinoIcons.chat_bubble,size: 20,),
                            SizedBox(width: 10,),
                            Center(child: Text('Proposed Chat Uploads: ', style: TextStyle(fontSize: 17)),
                            ),
                            Center(child: Text(' 1', style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 17),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10, top: 25)),
                    Text('Group Members'),
                  ],
                ),
              ],
            ),
            ListView.builder(
              itemCount: members.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return MembersList(
                  name: members[index].name, profileImage: members[index].profileImage,
                );},
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
          ],
        ),
      ),
    );
  }
}

     */