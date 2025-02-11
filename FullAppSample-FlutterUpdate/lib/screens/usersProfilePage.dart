import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/screens/chatPage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fullapp/widgets/chats.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersProfilePage extends StatefulWidget {
  @override
  _UsersProfilePageState createState() => _UsersProfilePageState();
}

class _UsersProfilePageState extends State<UsersProfilePage> {
  bool isReported = false; // Track whether the user is reported
  final urlImages = [
    'https://cdn-5.motorsport.com/images/amp/Y99dPvxY/s1000/carlos-sainz-ferrari-sf-23-1.jpg',
    'https://images.hola.com/us/images/027f-179cda03c4d8-364b39983d40-1000/square-480/lionel-messi.jpg',
    'https://images.unsplash.com/photo-1470468969717-61d5d54fd036?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTd8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80',
    'https://cdn.vox-cdn.com/thumbor/0AP0ZhM5bj2GWnbZf6a1CvMCYNA=/1400x1400/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/24609240/1478879983.jpg',
    'https://media.istockphoto.com/id/1355687112/photo/various-sport-equipment-gear.jpg?b=1&s=170667a&w=0&k=20&c=hEADFXL4HG9mF94yC5g3JA8lMHn8OZg7hRLoiel_L48=',
    'https://cdn.pixabay.com/photo/2017/09/25/23/10/tennis-2787158_640.png',
    'https://images.unsplash.com/photo-1561731216-c3a4d99437d5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80',
    'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Y2Fyc3xlbnwwfHwwfHw%3D&w=1000&q=80',
    'https://images.unsplash.com/photo-1628840042765-356cda07504e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVwcGVyb25pJTIwcGl6emF8ZW58MHx8MHx8&w=1000&q=80',
    'https://images.unsplash.com/photo-1598875706250-21faaf804361?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8OXx8fGVufDB8fHx8&w=1000&q=80',
    'https://images.unsplash.com/photo-1614027164847-1b28cfe1df60?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8&w=1000&q=80',
  ];

  final profileImage =
      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg'
  ;

  //this is the feed profile page another user would see
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text('@username', style: GoogleFonts.inter(color: Theme
            .of(context)
            .colorScheme
            .tertiary, fontWeight: FontWeight.bold, fontSize: 21),),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .surface,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, size: 30, color: Theme
              .of(context)
              .colorScheme
              .tertiary,),
          padding: EdgeInsets.only(right: 7, bottom: 7),
          // Remove default padding
          constraints: BoxConstraints(), // Removes size constraints
        ),
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
            ),


            SizedBox(height: 12,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('John Daver', style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),

            SizedBox(height: 3,),

            Text('49rs • Bulls • LSU', style: GoogleFonts.inter(color: Theme
                .of(context)
                .colorScheme
                .onTertiary),),

            Padding(
              padding: const EdgeInsets.only(
                  top: 15, right: 8, left: 8, bottom: 15),
              child: Text("Always supporting my teams",
                style: GoogleFonts.inter(fontSize: 15),
              ),
            ),

            Container(
              height: 45,
              width: 336,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChatsPage();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),

                child: Text('Message', style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold, color: Colors.white,),),
              ),
            ),

            SizedBox(height: 27,),


            Container(
              height: 45,
              width: 336,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isReported = true; // Change state to "reported"
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isReported
                      ? Colors.transparent // Transparent background for reported state
                      : Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: isReported? Theme.of(context).colorScheme.tertiary: Theme.of(context).colorScheme.primary,
                      width: isReported ? 2 : 0, // Outline when reported
                    ),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.exclamationmark_circle,
                      color: isReported
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.tertiary,
                    ),
                    SizedBox(width: 10),
                    Center(
                      child: Text(
                        isReported ? 'User Reported' : 'Report User',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: isReported
                              ? Theme.of(context).colorScheme.tertiary
                              : Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )

            /*
            Container(
              height: 45,
              width: 336,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                      Icon(CupertinoIcons.exclamationmark_circle, color: Theme
                          .of(context)
                          .colorScheme
                          .tertiary),

                      SizedBox(width: 10,),

                      Center(child: Text(
                          'Report User',
                          style: GoogleFonts.inter(fontSize: 15, color: Theme
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

             */

          ],
        ),
      ),
    );
  }
}