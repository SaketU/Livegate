import 'package:flutter/material.dart';
import 'package:fullapp/auth/loginPage.dart';
import 'package:fullapp/auth/signUpPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  //initially show login page
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage  = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showSignUpPage: toggleScreens);
    } else {
      return SignUpPage(showLoginPage: toggleScreens);
    }
  }
}
