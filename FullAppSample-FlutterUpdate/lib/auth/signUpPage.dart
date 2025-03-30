import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fullapp/auth/passwordPage.dart';
import 'package:fullapp/screens/homePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fullapp/models/square_tile.dart';
import 'package:fullapp/auth/verificationCodePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fullapp/auth/authPage.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SignUpPage extends StatefulWidget{
  final VoidCallback showLoginPage;
  const SignUpPage({Key? key, required this.showLoginPage,}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage> {

  // added toggle to login
  void toggleScreens() {
    widget.showLoginPage();
  }

  //text controller
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  //final _passwordController = TextEditingController();
  //final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

   Future signUp() async {
    // Update the endpoint URL to use /set-email instead of /create-account
    final url = Uri.parse('http://localhost:8000/set-email');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': _fullNameController.text.trim(),
          'email': _emailController.text.trim(),
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message'] ??
                'Email is valid. Proceeding to password page.'),
          ),
        );

        // Navigate to the PasswordPage and pass fullName and email as parameters
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordPage(
            fullName: _fullNameController.text.trim(), 
            email: _emailController.text.trim(),
          ),
        ),
      );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message'] ??
                'Email is invalid or already in use.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // bool passwordConfirmed() {
  //   if (_passwordController.text.trim() ==
  //       _confirmPasswordController.text.trim()) {
  //     return true;
  //   }
  //     else {
  //       return false;
  //   }
  // }


  @override
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

                SizedBox(height: screenHeight * 0.17),//149
            SvgPicture.asset(
              Theme.of(context).brightness == Brightness.dark?
              'assets/app_logos/LIVEGATE_dark.svg': 'assets/app_logos/LIVEGATE_light.svg',
              height: screenHeight * 0.062,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.tertiary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: screenHeight * 0.054),


                //Full Name
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
                  //obscureText: true,
                  controller: _fullNameController,
                  //controller: _passwordController,
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: InputDecoration(
                    //icon: Icon(CupertinoIcons.lock_fill,  color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'Full name',
                    hintStyle: GoogleFonts.interTight(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ),
            ),
                SizedBox(height: screenHeight * 0.012),
          
                //Email
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
                  //obscureText: true,
                  controller: _emailController,
                  //controller: _passwordController,
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: InputDecoration(
                    //icon: Icon(CupertinoIcons.lock_fill,  color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'Enter email or phone number',
                    hintStyle: GoogleFonts.interTight(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ),
            ),

                SizedBox(height: screenHeight * 0.075),

                Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.blue
                    : Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.interTight(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

            // "Or sign up with" divider
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
                    'Or sign up with',
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
                SquareTile(imagePath: 'assets/google.png'),
                SizedBox(width: 10),
                SquareTile(imagePath: 'assets/apple.png'),
              ],
            ),

                Spacer(),

                //sign up option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: GoogleFonts.interTight(color: Colors.grey, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(' Login Now', style: GoogleFonts.interTight(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14),),
                    ),
                  ],
                ),
              ],
            ),
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


//responsive working UI
/*
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
          
                SizedBox(height: screenHeight * 0.149),
                Text(
                  'Livegate',
                  style: GoogleFonts.interTight(fontSize: 62, fontWeight: FontWeight.bold),
                  // dmSerifText, playfairDisplay, openSans, interTight, roboto
                ),
                SizedBox(height: screenHeight * 0.034),
          
                //Email
                Container(
              height: 48,
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
                    icon: Icon(CupertinoIcons.lock_fill,  color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'Enter email or phone number',
                    hintStyle: GoogleFonts.interTight(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ),
            ),
                SizedBox(height: screenHeight * 0.012),
          
                //Password
                Container(
              height: 48,
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
                    icon: Icon(CupertinoIcons.lock_fill,  color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: GoogleFonts.interTight(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ),
            ),
                SizedBox(height: screenHeight * 0.012),

                // confirm Password
                Container(
              height: 48,
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
                    icon: Icon(CupertinoIcons.lock_fill,  color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'Confirm password',
                    hintStyle: GoogleFonts.interTight(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ),
            ),
                      
                SizedBox(height: screenHeight * 0.047),
                      
                Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.interTight(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

            // "Or sign up with" divider
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
                    'Or sign up with',
                    style: GoogleFonts.interTight(color: Colors.grey.shade700),
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

                Spacer(),

                //sign up option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: GoogleFonts.interTight(color: Colors.grey.shade500),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(' Login Now', style: GoogleFonts.interTight(color: Colors.blue, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ],
            ),
        ),
        ),
    );
  }
}
*/