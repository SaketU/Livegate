import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/models/chatGroupModel.dart';
import 'package:fullapp/auth/loginPage.dart';
import 'package:fullapp/screens/chatPage.dart';
import 'package:fullapp/screens/settings.dart';
import 'package:fullapp/screens/sourcePage.dart';
import 'package:fullapp/screens/usersProfilePage.dart';
import 'package:fullapp/widgets/groupsList.dart';
import 'package:fullapp/screens/profilePage.dart';
//code
class ExProfilePage extends StatefulWidget {

  @override
  _ExProfilePageState createState() => _ExProfilePageState();
}

class _ExProfilePageState extends State<ExProfilePage> {


  final profileImage =
      'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?cs=srgb&dl=pexels-mohamed-abdelghaffar-771742.jpg&fm=jpg'
  ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16,right: 16,top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return SourcePage();
                          }));
                        },
                        icon: Icon(CupertinoIcons.settings,color: Colors.grey.shade500,size: 30,),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image:
                  NetworkImage(profileImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 8, left: 8, bottom: 15),
                child: Text('Brad Johnson', style: TextStyle(fontSize: 20),
                ),
              ),

              /*
              Container(
                padding: EdgeInsets.only(top: 25, right: 12, left: 12, bottom: 20),
                height: 90,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ChatPage();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                ),
              ),

               */

              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: 0, top: 20)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return ProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.photo),
                                SizedBox(width: 10,),
                                Center(child: Text('Profile', style: TextStyle(fontSize: 17)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(
                          height: 5,
                          thickness: 1,
                          indent: 65,
                          endIndent: 0,
                        ),

                        Padding(
                            padding: EdgeInsets.only(bottom: 0, top: 0)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return UsersProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.barcode_viewfinder),
                                SizedBox(width: 10,),
                                Center(child: Text('Friend Code', style: TextStyle(fontSize: 17)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(
                          height: 5,
                          thickness: 1,
                          indent: 65,
                          endIndent: 0,
                        ),

                        Padding(
                            padding: EdgeInsets.only(bottom: 0, top: 0)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return UsersProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.check_mark_circled),
                                SizedBox(width: 10,),
                                Center(child: Text('Accept Friend Request', style: TextStyle(fontSize: 17)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(
                          height: 5,
                          thickness: 1,
                          indent: 65,
                          endIndent: 0,
                        ),

                        Padding(
                            padding: EdgeInsets.only(bottom: 0, top: 0)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return UsersProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.bookmark),
                                SizedBox(width: 10,),
                                Center(child: Text('Saved', style: TextStyle(fontSize: 17)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(
                          height: 5,
                          thickness: 1,
                          indent: 65,
                          endIndent: 0,
                        ),

                        Padding(
                            padding: EdgeInsets.only(bottom: 0, top: 0)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return UsersProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.heart),
                                SizedBox(width: 10,),
                                Center(child: Text('Liked', style: TextStyle(fontSize: 17)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(
                          height: 5,
                          thickness: 1,
                          indent: 65,
                          endIndent: 0,
                        ),
                      ],
                    ),
                  ]
              ),

              Padding(
                  padding: EdgeInsets.only(bottom: 0, top: 0)),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return UsersProfilePage();
                  }));
                },
                child: Container(
                  width: 350,
                  height: 50,
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(CupertinoIcons.bell),
                      SizedBox(width: 10,),
                      Center(child: Text('Notifications', style: TextStyle(fontSize: 17)),
                      ),
                    ],
                  ),
                ),
              ),

              const Divider(
                height: 5,
                thickness: 1,
                indent: 65,
                endIndent: 0,
              ),

            ]
        ),
      ),
    );
  }
}
/*
  final profileImage =
      'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?cs=srgb&dl=pexels-mohamed-abdelghaffar-771742.jpg&fm=jpg'
  ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16,right: 16,top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return SettingsPage();
                          }));
                        },
                        icon: Icon(CupertinoIcons.settings,color: Colors.grey.shade500,size: 30,),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image:
                  NetworkImage(profileImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 8, left: 8, bottom: 15),
                child: Text('Brad Johnson', style: TextStyle(fontSize: 20),
                ),
              ),

              /*
              Container(
                padding: EdgeInsets.only(top: 25, right: 12, left: 12, bottom: 20),
                height: 90,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ChatPage();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                ),
              ),

               */

              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: 0, top: 20)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return GroupProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.photo),
                                SizedBox(width: 10,),
                                Center(child: Text('Profile', style: TextStyle(fontSize: 17)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(
                          height: 5,
                          thickness: 1,
                          indent: 65,
                          endIndent: 0,
                        ),

                        Padding(
                            padding: EdgeInsets.only(bottom: 0, top: 0)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return UsersGroupProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.barcode_viewfinder),
                                SizedBox(width: 10,),
                                Center(child: Text('Friend Code', style: TextStyle(fontSize: 17)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(
                          height: 5,
                          thickness: 1,
                          indent: 65,
                          endIndent: 0,
                        ),

                        Padding(
                            padding: EdgeInsets.only(bottom: 0, top: 0)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return UsersGroupProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.check_mark_circled),
                                SizedBox(width: 10,),
                                Center(child: Text('Accept Friend Request', style: TextStyle(fontSize: 17)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(
                          height: 5,
                          thickness: 1,
                          indent: 65,
                          endIndent: 0,
                        ),

                        Padding(
                            padding: EdgeInsets.only(bottom: 0, top: 0)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return UsersGroupProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.bookmark),
                                SizedBox(width: 10,),
                                Center(child: Text('Saved', style: TextStyle(fontSize: 17)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(
                          height: 5,
                          thickness: 1,
                          indent: 65,
                          endIndent: 0,
                        ),

                        Padding(
                            padding: EdgeInsets.only(bottom: 0, top: 0)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return UsersGroupProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.heart),
                                SizedBox(width: 10,),
                                Center(child: Text('Liked', style: TextStyle(fontSize: 17)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(
                          height: 5,
                          thickness: 1,
                          indent: 65,
                          endIndent: 0,
                        ),
                      ],
                    ),
                  ]
              ),

              Padding(
                  padding: EdgeInsets.only(bottom: 0, top: 0)),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return UsersGroupProfilePage();
                  }));
                },
                child: Container(
                  width: 350,
                  height: 50,
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(CupertinoIcons.bell),
                      SizedBox(width: 10,),
                      Center(child: Text('Notifications', style: TextStyle(fontSize: 17)),
                      ),
                    ],
                  ),
                ),
              ),

              const Divider(
                height: 5,
                thickness: 1,
                indent: 65,
                endIndent: 0,
              ),

            ]
        ),
      ),
    );
  }
}

 */







