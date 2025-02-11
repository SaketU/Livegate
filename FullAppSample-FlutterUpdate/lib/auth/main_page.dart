import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/auth/authPage.dart';
import 'package:fullapp/intro_screens/loginPage.dart';
import 'package:fullapp/intro_screens/onboardingPage.dart';
import 'package:fullapp/screens/LivesPage.dart';
import 'package:fullapp/screens/homePage.dart';
import 'package:fullapp/widgets/livePages.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?> (
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return OnBoardingPage();
          }
          else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
