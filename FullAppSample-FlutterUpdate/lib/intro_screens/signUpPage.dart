import 'package:flutter/cupertino.dart';
import 'package:fullapp/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/intro_screens/onboardingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
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