import 'package:flutter/cupertino.dart';
import 'package:fullapp/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/intro_screens/onboardingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

//added these imports
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget{
  final VoidCallback showLoginPage;
  const SignUpPage({Key? key, required this.showLoginPage,}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage> {

  //text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //added text controller
  final _fullNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // handles signup
  Future signUp() async {
    // check if password matches confirmation
    if (!passwordConfirmed()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // backend signup endpoint
    final url = Uri.parse('http://localhost:8000/create-account');

    try {
      // post request to backend end point with user schema data
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': _fullNameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        }),
      );

      // json response from backend server
      final responseBody = jsonDecode(response.body);

      // successful registration
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['message'] ?? 'Registration Successful')),
        );

        // goes to home page if successful registration
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['message'] ?? 'Registration Failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    }
      else {
        return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Text(
              'Livegate',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40,),

            // Full Name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: _fullNameController,
                    cursorColor: Theme.of(context).colorScheme.tertiary,
                    decoration: InputDecoration(
                      icon: Icon(CupertinoIcons.person),
                      border: InputBorder.none,
                      hintText: 'Full Name',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),

            //Email
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
                        CupertinoIcons.mail,
                      ),
                      border: InputBorder.none,
                      hintText: 'Email or Phone Number',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12,),

            //Password
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

            SizedBox(height: 12,),

            // confirm Password
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
                    controller: _confirmPasswordController,
                    cursorColor: Theme.of(context).colorScheme.tertiary,
                    decoration: InputDecoration(
                      icon: Icon(
                        CupertinoIcons.lock_fill,
                      ),
                      border: InputBorder.none,
                      hintText: 'Confirm Password',
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                padding: EdgeInsets.only(top: 20, right: 12, left: 12, bottom: 20),
                height: 85,
                width: 600,
                child: ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 210,),

            //sign up option
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a member?",
                  style: TextStyle(fontWeight: FontWeight.bold
                  ),
                ),
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: Text(' Login Now', style: TextStyle(color: Colors.blue),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*
//Name
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
                    cursorColor: Theme.of(context).colorScheme.tertiary,
                    decoration: InputDecoration(
                      icon: Icon(
                        CupertinoIcons.person,
                      ),
                      border: InputBorder.none,
                      hintText: 'Name',
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 12,),

            //Username
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
 */