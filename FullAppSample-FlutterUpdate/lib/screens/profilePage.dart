import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fullapp/screens/chatPage.dart';
import 'package:fullapp/screens/settings.dart';
import 'package:fullapp/widgets/chats.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

void _signUserOut() {
  FirebaseAuth.instance.signOut();
}

class _ProfilePageState extends State<ProfilePage> {
  final urlImages = [
    'https://images.unsplash.com/photo-1561731216-c3a4d99437d5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80',
    'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Y2Fyc3xlbnwwfHwwfHw%3D&w=1000&q=80',
    'https://images.unsplash.com/photo-1628840042765-356cda07504e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVwcGVyb25pJTIwcGl6emF8ZW58MHx8MHx8&w=1000&q=80',
    'https://images.unsplash.com/photo-1598875706250-21faaf804361?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8OXx8fGVufDB8fHx8&w=1000&q=80',
    'https://images.unsplash.com/photo-1614027164847-1b28cfe1df60?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8&w=1000&q=80',
  ];

  final profileImage =
      'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?cs=srgb&dl=pexels-mohamed-abdelghaffar-771742.jpg&fm=jpg'
  ;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text('@username',style: GoogleFonts.inter(color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.bold, fontSize: 21),),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, size: 30, color: Theme.of(context).colorScheme.tertiary,),
          padding: EdgeInsets.only(right: 7, bottom: 7), // Remove default padding
          constraints: BoxConstraints(), // Removes size constraints
        ),
        //drawer that contains settings(navigates to settings page), saved, liked, etc

        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 24),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChatsPage();
              }));
            },
            icon: Transform(
              transform: Matrix4.identity()..scale(0.9, 1.2), // Adjust width (x) and height (y) scaling
              alignment: Alignment.center, // Keeps scaling centered
              child: Icon(
                Icons.person_add_alt_outlined, // Your desired icon
                size: 29, // Base size of the icon
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),




        ],
      ),
      body:
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(profileImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(1, 1.2), // Adjust alignment for position
                    child: Container(
                      width: 31, // Increased size
                      height: 31, // Increased size
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.surface, // Border color as container's background
                      ),
                      child: Center(
                        child: Container(
                          width: 24, // Smaller size to fit inside the border
                          height: 24, // Smaller size to fit inside the border
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue, // Blue background
                          ),
                          child: Icon(
                            Icons.add,
                            size: 18, // Adjust size as needed
                            color: Colors.white, // Icon color
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),




            SizedBox(height: 12,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Brad Johnson', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),

            SizedBox(height: 3,),

            Text('Ravens • Longhorns • Lakers', style: GoogleFonts.inter(color: Theme.of(context).colorScheme.onTertiary),),

            Padding(
              padding: const EdgeInsets.only(top: 15, right: 8, left: 8, bottom: 15),
              child: Text("Living life and seeing new things", style: GoogleFonts.inter(fontSize: 15),
              ),
            ),

            Container(
              height: 45,
              width: 336,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ChatsPage();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),

                child: Text('Edit Profile', style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Theme
                    .of(context)
                    .colorScheme
                    .tertiary,),),
              ),
            ),

            SizedBox(height: 27,),

            Container(
              height: 45,
              width: 336,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ChatsPage();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),

                child: Row(
                    children: <Widget>[
                      Icon(CupertinoIcons.brightness, color: Theme
                          .of(context)
                          .colorScheme
                          .tertiary),

                      SizedBox(width: 10,),

                      Center(child: Text(
                          'Display Mode', style: GoogleFonts.inter(fontSize: 15, color: Theme
                          .of(context)
                          .colorScheme
                          .tertiary)),
                      ),
                      Expanded(
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.right_chevron,
                              size: 15, color: Theme
                                    .of(context)
                                    .colorScheme
                                    .tertiary),
                          ],
                        ),
                      ),
                    ]
                ),
              ),
            ),

            SizedBox(height: 20,),

            Container(
              height: 45,
              width: 336,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ChatsPage();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),

                child: Row(
                    children: <Widget>[
                      Icon(CupertinoIcons.hand_raised, color: Theme
                          .of(context)
                          .colorScheme
                          .tertiary),

                      SizedBox(width: 10,),

                      Center(child: Text(
                          'Help', style: GoogleFonts.inter(fontSize: 15, color: Theme
                          .of(context)
                          .colorScheme
                          .tertiary)),
                      ),
                      Expanded(
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.right_chevron,
                                size: 15, color: Theme
                                    .of(context)
                                    .colorScheme
                                    .tertiary),
                          ],
                        ),
                      ),
                    ]
                ),
              ),
            ),

            SizedBox(height: 20,),

            Container(
              height: 45,
              width: 336,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ChatsPage();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),

                child: Row(
                    children: <Widget>[
                      Icon(CupertinoIcons.info, color: Theme
                          .of(context)
                          .colorScheme
                          .tertiary),

                      SizedBox(width: 10,),

                      Center(child: Text(
                          'About', style: GoogleFonts.inter(fontSize: 15, color: Theme
                          .of(context)
                          .colorScheme
                          .tertiary)),
                      ),
                      Expanded(
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.right_chevron,
                                size: 15, color: Theme
                                    .of(context)
                                    .colorScheme
                                    .tertiary),
                          ],
                        ),
                      ),
                    ]
                ),
              ),
            ),

            SizedBox(height: 32,),

            Container(
              height: 45,
              width: 336,
              child: ElevatedButton(
                onPressed: _signUserOut,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),

                child: Text('Log out', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white,),),
              ),
            ),

          ],
        ),
      ),
    );
  }

  //When images are shown in the profile page
  /* Widget makeDismissible ({required Widget child}) => GestureDetector(
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
                Padding(
                    padding: EdgeInsets.only(bottom: 0, top: 0)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return SettingsPage();
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
                        Icon(CupertinoIcons.settings),
                        SizedBox(width: 10,),
                        Center(child: Text('Settings', style: TextStyle(fontSize: 17)),
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
          ),
    ),
  );


  Widget buildImage(String urlImage, int index) => Padding(
    padding: EdgeInsets.all(3),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    ),
  );

   */
}




    /*
    return Scaffold(
      appBar: AppBar(
        title: Text('@username',),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              CupertinoIcons.add_circled_solid,size: 35,
            ),

          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
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
              padding: const EdgeInsets.only(top: 10, right: 8, left: 8, bottom: 10),
              child: Text('Bio', style: TextStyle(fontSize: 15),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child:Row(
                children: [
                  Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text('1.2M',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,),
                            ),
                            Text('Likes',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text('70',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,),
                        ),
                        Text('Posts',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text('128.5k',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,),
                            ),
                            Text('Followers',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
            OutlinedButton(
              style: TextButton.styleFrom(
                minimumSize: Size(350,40),
                textStyle: TextStyle(fontSize: 15),
                primary: Colors.grey,
              ),
              onPressed: () {

              },
              child: Text('Edit Profile'),
            ),
            SizedBox(
              height: 15,
            ),

            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: urlImages.length,
              itemBuilder: (context, index) {
                final urlImage = urlImages[index];

                return buildImage(urlImage, index);
                },
            ),
          ],
        ),
      ),
    );
  }
  Widget buildImage(String urlImage, int index) => Padding(
    padding: EdgeInsets.all(2),
    child: Container(
      height: 100,
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    ),
  );
}

     */


