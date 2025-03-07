import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
//code
class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  

  final profileImage =
      'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?cs=srgb&dl=pexels-mohamed-abdelghaffar-771742.jpg&fm=jpg';

      //could make a model for your username, name and picture to be stored



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensures proper spacing
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: GoogleFonts.interTight(
                    fontSize: screenHeight * 0.019,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              Spacer(), // Pushes title to center
              Text(
                'Edit Profile',
                style: GoogleFonts.interTight(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.019,
                ),
              ),
              Spacer(), // Pushes "Done" to right
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  "Done",
                  style: GoogleFonts.interTight(
                    fontSize: screenHeight * 0.019,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.23, // 90px equivalent
                      height: MediaQuery.of(context).size.width * 0.23, // 90px equivalent
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(profileImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight*0.0142,),
              
                  Text('Edit profile picture', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.016, color: Colors.blue)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 21.0, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Subject on the left
                  Text(
                    'Name: ',
                    style: GoogleFonts.interTight(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.016,
                      color: Colors.black,
                    ),
                  ),
                  
                  // TextField on the right displaying current username
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: TextEditingController(text: 'currentname'), // Display current username
                        readOnly: true,  // Make it read-only if you want the user to only view it
                        style: GoogleFonts.interTight(
                          fontSize: screenHeight * 0.016,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right, // Align text to the right
                        decoration: InputDecoration(
                          border: InputBorder.none, // Remove the border
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black), // Bottom border
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black), // Bottom border
                          ),
                          isDense: true, // Reduces the height of the TextField
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
    );
  }
}