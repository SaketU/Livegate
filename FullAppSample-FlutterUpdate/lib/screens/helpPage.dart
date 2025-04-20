import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
   @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Help Center',style: GoogleFonts.interTight(color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.bold, fontSize: screenHeight*0.021),),
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
      ),
      body: Padding(
    padding: EdgeInsets.symmetric(horizontal: 21.0),
    child: SingleChildScrollView(
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.inter(fontSize: screenHeight*0.018, color: Theme.of(context).colorScheme.tertiary, height: 1.4, fontWeight: FontWeight.w500),
          children: [
            TextSpan(text: 'Help & Support\n\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.024)),
            
            TextSpan(text: 'Welcome to the Help & Support page! If you need assistance using our app, you’ve come to the right place. Below, you’ll find answers to common questions and ways to contact our support team.\n\n'),
            
            TextSpan(text: 'Getting Started\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.021,)),
            WidgetSpan(child: SizedBox(height: 30),),
            TextSpan(text: 'How do I create an account?\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.019)),
            TextSpan(text: '1. Open the app and tap "Sign Up."\n2. Enter your email and create a password.\n3. Set up your preferences and start using the app!\n\n'),
            
            TextSpan(text: 'How do I log in?\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.019)),
            TextSpan(text: 'Simply open the app, tap "Log In" and enter your registered email or username and password.\n\n'),
            
            TextSpan(text: 'What if I forgot my password?\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.019)),
            TextSpan(text: 'Tap "Forgot Password?" on the login screen, enter your email, and follow the instructions to reset your password.\n\n'),
            
            TextSpan(text: 'Using the App\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.021)),
            WidgetSpan(child: SizedBox(height: 30),),
            TextSpan(text: 'How do chat rooms work?\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.019)),
            TextSpan(text: 'Live chat rooms are active conversations about games that are happening in real time. You can join and leave the chat whenever you want.\n\n'),
            
            TextSpan(text: 'How do I send a message?\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.019)),
            TextSpan(text: 'Locate the chat that you want to join and tap on it to enter. Once inside you can start typing your message and send into to the discussion.\n\n'),
            
            TextSpan(text: 'How do I update my profile?\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.019)),
            TextSpan(text: 'On the home page tap the profile icon at the top left > Then select the "Edit Profile" button. Once in the edit profile page just tap on the fields you want to edit.\n\n'),
            
            TextSpan(text: 'Account & Privacy\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.021)),
            WidgetSpan(child: SizedBox(height: 30),),
            TextSpan(text: 'What is the Privacy Policy?\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.019)),
            TextSpan(text: 'Feel free to review our Privacy Policy so you can be well informed of how we collect and use information.\n\n'),
            /*
            TextSpan(text: 'How do I delete my account?\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.019)),
            TextSpan(text: 'If you wish to delete your account, go to "Settings" > "Account" > "Delete Account." This action is irreversible.\n\n'),
            */
            TextSpan(text: 'Troubleshooting\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.021)),
            WidgetSpan(child: SizedBox(height: 30),),
            TextSpan(text: 'The app is not working properly. What should I do?\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.019)),
            TextSpan(text: 'Try the following steps:\n• Ensure your app is updated to the latest version.\n• Restart your device.\n• Clear the app’s cache in your device settings.\n• Uninstall and reinstall the app.\n\n'),
            
            TextSpan(text: 'I’m not receiving notifications.\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.019)),
            TextSpan(text: 'Make sure notifications are enabled in your device settings and within the app under "Settings" > "Notifications."\n\n'),
            
            TextSpan(text: 'Contact Support\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.021)),
            WidgetSpan(child: SizedBox(height: 30),),
            TextSpan(text: 'If you need further assistance, reach out to our support team:\n\n'),
            TextSpan(text: '• Email: support@yourapp.com\n\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold)),
          
            
            TextSpan(text: 'We’re here to help!\n'),
          ],
        ),
      ),
    ),
  ),
    );
  }
}