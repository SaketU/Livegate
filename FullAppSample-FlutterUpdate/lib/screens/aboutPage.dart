import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
   @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text('About',style: GoogleFonts.interTight(color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.bold, fontSize: screenHeight*0.021,),),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, size: 30, color: Theme.of(context).colorScheme.tertiary,),
          padding: EdgeInsets.only(right: 7, bottom: 7), 
          constraints: BoxConstraints(), // Removes size constraints
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.0),
        child: SingleChildScrollView(
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.interTight(fontSize: screenHeight*0.018, color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.w500, height: 1.4),
              children: [
                TextSpan(text: 'Privacy Policy\n\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.024)),
                TextSpan(text: 'Effective Date: [Insert Date]\n\n'),
                
                
                TextSpan(text: 'We at Livegate want you to understand what information we collect, and how we use and share it. Your privacy is important to us, which is why we encourage you to read our Privacy Policy. This helps us provide the best experience possible for you.\n\n'),
                TextSpan(text: 'In the Privacy Policy, we explain how we collect, use, share, retain and transfer information. We let you know why we collect this information and how we use it. Each section of this policy includes specifications and simpler language to make our practices easier to understand. \n\n'),
                TextSpan(text: 'It’s important to us that you know your privacy is protected, and that all the data that we gather is used to improve our service for you to have a better experience in the app.\n\n', style: GoogleFonts.interTight()),
                
                TextSpan(text: 'Information We Collect\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.021)),
                WidgetSpan(child: SizedBox(height: 30),),
                TextSpan(text: 'We only collect information that is generated within the app, including:\n'),
                TextSpan(text: '• User-Provided Information: ', style: GoogleFonts.interTight(fontWeight: FontWeight.bold)),
                TextSpan(text: 'When you create an account, we collect your name, email or phone number, username, profile picture, preferences and any other details you provide.\n'),
                TextSpan(text: '• In-App Activity: ', style: GoogleFonts.interTight(fontWeight: FontWeight.bold)),
                TextSpan(text: 'We collect data related to your interactions within the app. This includes  live chats joined, duration of engagement, number of interactions, reactions, and page engagement.\n'),
                TextSpan(text: '• Device Information: ', style: GoogleFonts.interTight(fontWeight: FontWeight.bold)),
                TextSpan(text: 'We may collect technical information about your device, such as app version and performance metrics, to enhance user experience.\n\n'),
                
                TextSpan(text: 'How We Collect Information\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.021)),
                WidgetSpan(child: SizedBox(height: 30),),
                TextSpan(text: '• Direct Input: ', style: GoogleFonts.interTight(fontWeight: FontWeight.bold)),
                TextSpan(text: 'Information you provide when using features such as live chats, preferences, or updating your profile.\n'),
                TextSpan(text: '• Automated Data Collection: ', style: GoogleFonts.interTight(fontWeight: FontWeight.bold)),
                TextSpan(text: 'We automatically collect certain usage data to improve app functionality and security.\n'),
                TextSpan(text: '• Cookies and Tracking Technologies: ', style: GoogleFonts.interTight(fontWeight: FontWeight.bold)),
                TextSpan(text: 'We use in-app analysis mechanisms to personalize your experience and improve our services. All the information we collect is from your activity within the app, we do not collect any external information. \n\n'),
                
                TextSpan(text: 'How We Use Your Information\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.021)),
                WidgetSpan(child: SizedBox(height: 30),),
                TextSpan(text: 'We use collected information to provide a personalized experience to you, including ads, along with the other purposes we explain in detail below.\n Here are the ways we use Information: \n• Provide, personalize, and improve our app experience.\n• Facilitate communication and social interactions within the app.\n• Analyze usage patterns to optimize app performance.\n• Ensure safety, security, and compliance with our policies.\n\n'),
                
                TextSpan(text: 'How We Share Your Information\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.021)),
                WidgetSpan(child: SizedBox(height: 30),),
                TextSpan(text: 'We do not sell or share your information with third-party advertisers. However, we may share information in the following cases:\n'),
                TextSpan(text: '• With Other Users: ', style: GoogleFonts.interTight(fontWeight: FontWeight.bold)),
                TextSpan(text: 'Information such as your profile name, username, team preferences, and bio may be visible to other users as part of normal app functionality.\n'),
                TextSpan(text: '• With Service Providers: ', style: GoogleFonts.interTight(fontWeight: FontWeight.bold)),
                TextSpan(text: 'We may share necessary data with trusted partners who assist in app operations, such as hosting services.\n'),
                TextSpan(text: '• Legal Requirements: ', style: GoogleFonts.interTight(fontWeight: FontWeight.bold)),
                TextSpan(text: 'If required by law, we may disclose information to comply with legal obligations or protect our users\' rights and safety.\n\n'),
                
                TextSpan(text: 'Data Security\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.021)),
                WidgetSpan(child: SizedBox(height: 30),),
                TextSpan(text: 'We take reasonable measures to protect your information from unauthorized access, loss, or misuse. However, no security system is completely impenetrable. Do not share sensible information on live chats or any other features. We will never ask you for sensitive information such as credit card information or SSN.\n\n'),
                
                TextSpan(text: 'Your Choices and Controls\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.021)),
                WidgetSpan(child: SizedBox(height: 30),),
                TextSpan(text: 'You can control certain aspects of your information, including:\n• Updating or deleting your profile information.\n• People who can join your social graph\n• Contacting us for any privacy-related concerns.\n\n'),
                
                TextSpan(text: 'Changes to This Privacy Policy\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.021)),
                WidgetSpan(child: SizedBox(height: 30),),
                TextSpan(text: 'We may update this policy from time to time. We will notify you of significant changes by updating the “Effective Date” and, where required, providing additional notice within the app.\n\n'),
                
                TextSpan(text: 'Contact Us\n', style: GoogleFonts.interTight(fontWeight: FontWeight.bold, fontSize: screenHeight*0.021)),
                WidgetSpan(child: SizedBox(height: 30),),
                TextSpan(text: 'If you have any questions about this Privacy Policy, you can contact us at [Insert Contact Information].\n'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}