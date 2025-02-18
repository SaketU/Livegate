import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullapp/intro_screens/signUpPage.dart';
import 'package:fullapp/models/square_tile.dart';
import 'package:fullapp/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/intro_screens/onboardingPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget{
  final VoidCallback showSignUpPage;
  const LoginPage({Key? key, required this.showSignUpPage}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future logIn() async {
  final url = Uri.parse('http://localhost:8000/login');


  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
      }),
    );


    final responseBody = jsonDecode(response.body);


    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseBody['message'] ?? 'Login Successful')),);


      // Navigate to home page after successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseBody['message'] ?? 'Login Failed')),);
    }
    } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error: $e')),
    );
  }
}


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Name of app

            SizedBox(height: 180,),//200, 150, 180
            Text(
              'Livegate',

              style: GoogleFonts.workSans(fontSize: 65, fontWeight: FontWeight.bold),
              // dmSerifText, playfairDisplay, openSans, inter, roboto
            ),
            SizedBox(height: 40,), //20, 70, 40

            //username textfield
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                  border:Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: _emailController,
                    cursorColor: Theme.of(context).colorScheme.tertiary,
                    decoration: InputDecoration(
                      icon: Icon(
                        CupertinoIcons.person_fill,
                      ),
                      border: InputBorder.none,
                      hintText: 'Username',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12,),

            //password textfield
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                  border:Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    cursorColor: Theme.of(context).colorScheme.tertiary,
                    decoration: InputDecoration(
                      icon: Icon(
                        CupertinoIcons.lock_fill,
                      ),
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            //forgot password button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                Padding(
                    padding: EdgeInsets.only(left: 100)),

                GestureDetector(
                  onTap: () {

                  },
                  child:Text('Forgot Password?', style: TextStyle(color: Colors.grey.shade500),),
                ),
              ],
            ),
            SizedBox(height: 20,),

            //login button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                padding: EdgeInsets.only(top: 20, right: 12, left: 12, bottom: 20),
                height: 85,
                width: 600,
                child: ElevatedButton(
                  onPressed: logIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),

            //or continue with
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Or continue with', style: TextStyle(color: Colors.grey.shade700),),

                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 50,),

            //Apple and Google Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(imagePath: 'lib/Images App/Google-Logo.png'),

                SizedBox(width: 10,),

                SquareTile(imagePath: 'lib/Images App/Apple-Logo.png'),
              ],
            ),


            SizedBox(height: 60,),

            //sign up option
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account?",
                  style: TextStyle(fontWeight: FontWeight.bold
                  ),
                ),
                GestureDetector(
                  onTap: widget.showSignUpPage,
                  child: Text(' Sign Up', style: TextStyle(color: Colors.blue),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}