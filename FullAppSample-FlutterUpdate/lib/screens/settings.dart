import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:fullapp/intro_screens/loginPage.dart';
import 'package:fullapp/intro_screens/signUpPage.dart';
import 'package:fullapp/screens/usersProfilePage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});



  void _signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Settings', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.tertiary),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, color: Theme.of(context).colorScheme.tertiary,),
        ),
      ),

      body:
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: 0, top: 20)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons
                                    .person_crop_circle_fill_badge_checkmark),
                                SizedBox(width: 10,),
                                Center(child: Text(
                                    'Account', style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.lock_fill),
                                SizedBox(width: 10,),
                                Center(child: Text(
                                    'Privacy', style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.chat_bubble_fill),
                                SizedBox(width: 10,),
                                Center(child: Text(
                                    'Chats', style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.arrow_up_arrow_down),
                                SizedBox(width: 10,),
                                Center(child: Text('Storage and Data',
                                    style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.lock_shield_fill),
                                SizedBox(width: 10,),
                                Center(child: Text(
                                    'Security', style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.hand_raised_fill),
                                SizedBox(width: 10,),
                                Center(child: Text(
                                    'Help', style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.info_circle_fill),
                                SizedBox(width: 10,),
                                Center(child: Text(
                                    'About', style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 20),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 25, right: 12, left: 12, bottom: 20),
                            height: 85,
                            width: 300,
                            child: ElevatedButton(
                              onPressed: _signUserOut,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text('Log Out', style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  }


    /*
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      appBar: AppBar(
        title: Text(
          'Settings', style: TextStyle(fontSize: 30, fontWeight: FontWeight
            .bold, color: Theme
            .of(context)
            .colorScheme
            .tertiary),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, color: Theme
              .of(context)
              .colorScheme
              .tertiary,),
        ),
      ),

      body:
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: 0, top: 20)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersGroupProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons
                                    .person_crop_circle_fill_badge_checkmark),
                                SizedBox(width: 10,),
                                Center(child: Text(
                                    'Account', style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersGroupProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.lock_fill),
                                SizedBox(width: 10,),
                                Center(child: Text(
                                    'Privacy', style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersGroupProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.chat_bubble_fill),
                                SizedBox(width: 10,),
                                Center(child: Text(
                                    'Chats', style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersGroupProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.arrow_up_arrow_down),
                                SizedBox(width: 10,),
                                Center(child: Text('Storage and Data',
                                    style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersGroupProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.lock_shield_fill),
                                SizedBox(width: 10,),
                                Center(child: Text(
                                    'Security', style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersGroupProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.hand_raised_fill),
                                SizedBox(width: 10,),
                                Center(child: Text(
                                    'Help', style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UsersGroupProfilePage();
                            }));
                          },
                          child: Container(
                            width: 350,
                            height: 50,
                            padding: const EdgeInsets.only(left: 15, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.info_circle_fill),
                                SizedBox(width: 10,),
                                Center(child: Text(
                                    'About', style: TextStyle(fontSize: 17)),
                                ),
                                Expanded(
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(CupertinoIcons.right_chevron,
                                        size: 15,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 20),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 25, right: 12, left: 12, bottom: 20),
                            height: 85,
                            width: 300,
                            child: ElevatedButton(
                              onPressed: signUserOut,
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text('Log Out', style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

     */