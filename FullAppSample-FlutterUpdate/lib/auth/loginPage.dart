import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fullapp/models/square_tile.dart';
//code
class LoginPage extends StatefulWidget {
  final VoidCallback showSignUpPage;

  const LoginPage({Key? key, required this.showSignUpPage}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future logIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
  return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.surface,
    body: SafeArea(
      top: true,
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Name of app
            SizedBox(height: screenHeight * 0.17),//149
            Text(
              'Livegate',
              style: GoogleFonts.interTight(
                fontSize: 55, fontWeight: FontWeight.bold //62
              ),
            ),
            SizedBox(height: screenHeight * 0.034),
            
            // Username textfield
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark?
                Colors.white10 : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  controller: _emailController,
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: InputDecoration(
                    //icon: Icon(CupertinoIcons.person_fill,  color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'Username or email',
                    hintStyle: GoogleFonts.interTight(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.012),
            
            // Password textfield
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark?
                Colors.white10 : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: InputDecoration(
                    //icon: Icon(CupertinoIcons.lock_fill,  color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: GoogleFonts.interTight(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
                        
            // Forgot password button aligned to the container
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      'Forgot password?',
                      style: GoogleFonts.interTight(
                        color: Colors.grey.shade500, 
                        fontSize: 15
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.035),
                        
            // Login button
            Container(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: logIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Log In',
                  style: GoogleFonts.interTight(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),

            // "Or continue with" divider
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade400,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Or continue with',
                    style: GoogleFonts.interTight(color: Colors.grey.shade600),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: screenHeight * 0.05),

            // Apple and Google Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(imagePath: 'lib/Images App/Google-Logo.png'),
                SizedBox(width: 10),
                SquareTile(imagePath: 'lib/Images App/Apple-Logo.png'),
              ],
            ),

            Spacer(), // Pushes the sign-up row to the bottom

            // Sign-up option with text wrapping
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.interTight(color: Colors.grey, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: widget.showSignUpPage,
                      child: Text(
                        ' Sign Up',
                        style: GoogleFonts.interTight(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}






/*
Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Name of app

            SizedBox(height:screenHeight * 0.23,),
            Text(
              'Livegate',
              style: GoogleFonts.interTight(fontSize: screenHeight * 0.065, fontWeight: FontWeight.bold),
              // dmSerifText, playfairDisplay, openSans, interTight, roboto
            ),
            SizedBox(height: screenHeight * 0.04,), //20, 70, 40

            //username textfield
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
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
                      hintText: 'Username',hintStyle: GoogleFonts.interTight(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.012,),

            //password textfield
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        cursorColor: Theme.of(context).colorScheme.tertiary,
                        decoration: InputDecoration(
                          icon: Icon(CupertinoIcons.lock_fill),
                          border: InputBorder.none,
                          hintText: 'Password', hintStyle: GoogleFonts.interTight(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),

                  // Forgot password button aligned to the container
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.interTight(color: Colors.grey.shade500, fontSize: screenHeight * 0.015),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.035),

                  // Login button as wide as the password container
                  Container(
                    width: double.infinity,
                    height: 50, //50
                    child: ElevatedButton(
                      onPressed: logIn,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Log In',
                        style: GoogleFonts.interTight(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15, //15
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.07,),

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
                    child: Text('Or continue with', style: GoogleFonts.interTight(color: Colors.grey.shade700),),

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

            SizedBox(height: screenHeight * 0.05,),

            //Apple and Google Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(imagePath: 'lib/Images App/Google-Logo.png'),

                SizedBox(width: 10,),

                SquareTile(imagePath: 'lib/Images App/Apple-Logo.png'),
              ],
            ),


            SizedBox(height: screenHeight * 0.130,), //110

            //sign up option
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account?",
                  style: GoogleFonts.interTight(fontWeight: FontWeight.bold
                  ),
                ),
                GestureDetector(
                  onTap: widget.showSignUpPage,
                  child: Text(' Sign Up', style: GoogleFonts.interTight(color: Colors.blue, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
 */


//original
/*
Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Name of app

            SizedBox(height: 200,),//200
            Text(
              'Livegate',
              style: GoogleFonts.interTight(fontSize: 65, fontWeight: FontWeight.bold),//65
              // dmSerifText, playfairDisplay, openSans, interTight, roboto
            ),
            SizedBox(height: 40,), //20, 70, 40

            //username textfield
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
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
                      hintText: 'Username',hintStyle: GoogleFonts.interTight(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12,),

            //password textfield
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        cursorColor: Theme.of(context).colorScheme.tertiary,
                        decoration: InputDecoration(
                          icon: Icon(CupertinoIcons.lock_fill),
                          border: InputBorder.none,
                          hintText: 'Password', hintStyle: GoogleFonts.interTight(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Forgot password button aligned to the container
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.interTight(color: Colors.grey.shade500, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),

                  // Login button as wide as the password container
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: logIn,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Log In',
                        style: GoogleFonts.interTight(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 70,),

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
                    child: Text('Or continue with', style: GoogleFonts.interTight(color: Colors.grey.shade700),),

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


            SizedBox(height: 110,),

            //sign up option
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account?",
                  style: GoogleFonts.interTight(fontWeight: FontWeight.bold
                  ),
                ),
                GestureDetector(
                  onTap: widget.showSignUpPage,
                  child: Text(' Sign Up', style: GoogleFonts.interTight(color: Colors.blue, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
 */