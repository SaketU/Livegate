import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/auth/authPage.dart';
import 'package:fullapp/screens/aboutPage.dart';
import 'package:fullapp/screens/displayPage.dart';
import 'package:fullapp/screens/editProfilePage.dart';
import 'package:fullapp/screens/helpPage.dart';
import 'package:fullapp/widgets/chats.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullapp/services/socket_manager.dart'; // Import your SocketManager
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fullapp/config.dart';

class UserData {
  final String fullName;
  final String username;
  final String email;
  final List<dynamic> leaguePreferences;

  UserData({
    required this.fullName,
    required this.username,
    required this.email,
    required this.leaguePreferences,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      fullName: json['fullName'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      leaguePreferences: json['leaguePreferences'] ?? [],
    );
  }
}

//code
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
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
      'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?cs=srgb&dl=pexels-mohamed-abdelghaffar-771742.jpg&fm=jpg';

  final storage = FlutterSecureStorage();
  UserData? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final token = await storage.read(key: 'accessToken');
      if (token == null) {
        throw Exception('No access token found');
      }

      final response = await http.get(
        Uri.parse('$kBackendBaseUrl/api/user/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          userData = UserData.fromJson(data);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data')),
      );
    }
  }

  void _signUserOut() {
    // Disconnect the socket before logging out.
    SocketManager().disconnect();

    FirebaseAuth.instance.signOut();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isLoading ? 'Loading...' : '@${userData?.username ?? "username"}',
          style: GoogleFonts.interTight(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.bold,
              fontSize: screenHeight * 0.0248),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.back,
            size: 30,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          padding:
              EdgeInsets.only(right: 7, bottom: 7), // Remove default padding
          constraints: BoxConstraints(), // Removes size constraints
        ),
        //drawer that contains settings(navigates to settings page), saved, liked, etc

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 21),
            child: SvgPicture.asset(
              'assets/add_account.svg',
              height: screenHeight * 0.0308,
              width: screenWidth * 0.0308,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.tertiary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width:
                    MediaQuery.of(context).size.width * 0.23, // 90px equivalent
                height:
                    MediaQuery.of(context).size.width * 0.23, // 90px equivalent
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
                      alignment:
                          Alignment(1, 1.2), // Adjust alignment for position
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            0.08, // 31px equivalent
                        height: MediaQuery.of(context).size.width *
                            0.08, // 31px equivalent
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context)
                              .colorScheme
                              .background, // Border color as container's background
                        ),
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width *
                                0.06, // 24px equivalent
                            height: MediaQuery.of(context).size.width *
                                0.06, // 24px equivalent
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue, // Blue background
                            ),
                            child: Icon(
                              Icons.add,
                              size: MediaQuery.of(context).size.width *
                                  0.045, // 18px equivalent
                              color: Colors.white, // Icon color
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.0142,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isLoading ? 'Loading...' : userData?.fullName ?? 'User',
                    style: GoogleFonts.interTight(
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * 0.018)),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.00355,
            ),
            Text(
              isLoading
                  ? ''
                  : userData?.leaguePreferences.join(' • ') ??
                      'No preferences set',
              style: GoogleFonts.interTight(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontSize: screenHeight * 0.018),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 14, right: 8, left: 8, bottom: 15),
              child: Text(
                "Living life and seeing new things",
                style: GoogleFonts.interTight(fontSize: screenHeight * 0.018),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21.0),
              child: Container(
                height: screenHeight * 0.0533,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            EditProfilePage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0); // Start from bottom
                          const end = Offset.zero; // End at normal position
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.interTight(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.0319,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: SizedBox(
                height: screenHeight * 0.0533,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DisplayPage();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.only(
                        left: 12, right: 14), // Reduce extra padding
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.max, // Ensures row takes full width
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/display_mode.svg',
                        height: screenHeight * 0.032,
                        width: screenWidth * 0.032,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.tertiary,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 7), // Adjust spacing
                      Text(
                        'Display Mode',
                        style: GoogleFonts.interTight(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Spacer(), // Pushes the icon to the right
                      Icon(
                        CupertinoIcons.right_chevron,
                        size: 18,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.0236,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: SizedBox(
                height: screenHeight * 0.0533,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HelpPage();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.only(
                        left: 17, right: 14), // Adjust horizontal padding
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.max, // Use max to make full width
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/help.svg',
                        height: screenHeight * 0.0308,
                        width: screenWidth * 0.0213,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.tertiary,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 11), // Adjust spacing
                      Text(
                        'Help',
                        style: GoogleFonts.interTight(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Spacer(), // Pushes the icon to the right
                      Icon(
                        CupertinoIcons.right_chevron,
                        size: 18,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.0236,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: SizedBox(
                height: screenHeight * 0.0533,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AboutPage();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.only(
                        left: 15, right: 14), // Reduce extra padding
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.max, // Ensures row takes full width
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/info.svg',
                        height: screenHeight * 0.0272,
                        width: screenWidth * 0.0272,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.tertiary,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 9), // Adjust spacing
                      Text(
                        'About',
                        style: GoogleFonts.interTight(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Spacer(), // Pushes the icon to the right
                      Icon(
                        CupertinoIcons.right_chevron,
                        size: 18,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.0379,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21.0),
              child: Container(
                height: screenHeight * 0.0533,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _signUserOut,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Color(0xFF007AFF)
                            : Theme.of(context).colorScheme.tertiary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Log out',
                    style: GoogleFonts.interTight(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
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