import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/auth/authPage.dart';
import 'package:fullapp/auth/loginPage.dart';
import 'package:fullapp/intro_screens/onboardingPage.dart';
import 'package:fullapp/screens/LivesPage.dart';
import 'package:fullapp/screens/homePage.dart';
import 'package:fullapp/widgets/livePages.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final storage = FlutterSecureStorage();
  bool isLoading = true;
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    final token = await storage.read(key: 'accessToken');
    setState(() {
      isAuthenticated = token != null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: isAuthenticated ? LivePages() : AuthPage(),
    );
  }
}
