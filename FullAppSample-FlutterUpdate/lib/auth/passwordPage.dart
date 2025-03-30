import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fullapp/intro_screens/leaguePreference.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fullapp/models/square_tile.dart';
import 'package:fullapp/auth/verificationCodePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final FlutterSecureStorage storage = FlutterSecureStorage();


//added fullname and email as parameters
class PasswordPage extends StatefulWidget {
  final String fullName;
  final String email;

  const PasswordPage({
    Key? key,
    required this.fullName,
    required this.email,
  }) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}
class _PasswordPageState extends State<PasswordPage> {

  //text controller
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<bool> confirmPassword() async {
    if (!passwordConfirmed()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match.")),
      );
      return false;
    }

    final url = Uri.parse('http://localhost:8000/set-password');
    try {
      final body = jsonEncode({
        'fullName': widget.fullName,
        'email': widget.email,
        'username': _usernameController.text.trim(),
        'password': _passwordController.text.trim(),
        'confirmPassword': _confirmPasswordController.text.trim(),
      });

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Save the JWT token securely.
        final String token = responseBody['accessToken'];
        await storage.write(key: 'accessToken', value: token);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message'] ??
                'Account created successfully'),
          ),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message'] ??
                'Error creating account'),
          ),
        );
        return false;
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return false;
    }
  }

bool passwordConfirmed() {
  return _passwordController.text.trim() ==
         _confirmPasswordController.text.trim();
}

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign up',
          style: GoogleFonts.interTight(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.back,
            size: 30,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.025),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Create your username and password",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.interTight(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Use a strong password to secure your account',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.interTight(
                    color: Colors.grey,//shade600
                    fontSize: 14,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.045),

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
                  controller: _usernameController,
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: InputDecoration(
                    //icon: Icon(CupertinoIcons.lock_fill,  color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'Create username',
                    hintStyle: GoogleFonts.interTight(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ),
            ),
                SizedBox(height: screenHeight * 0.012),

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
                SizedBox(height: screenHeight * 0.012),

                Container(
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ?
                Colors.white10 : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  obscureText: true,
                  controller: _confirmPasswordController,
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  decoration: InputDecoration(
                    //icon: Icon(CupertinoIcons.lock_fill,  color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'Confirm password',
                    hintStyle: GoogleFonts.interTight(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ),
            ),
              Spacer(), 

              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centers the row content
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center, // Aligns the text in the middle
                      child: RichText(
                        textAlign: TextAlign.center, // Centers the text itself
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'By continuing, you agree to our',
                              style: GoogleFonts.interTight(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                            TextSpan(
                              text: ' Terms of Service',
                              style: GoogleFonts.interTight(
                                color: Theme.of(context).brightness == Brightness.dark 
                                    ? Colors.grey.shade500 // Dark mode color
                                    : Colors.grey.shade800, // Light mode color
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' and acknowledge that you have read our',
                              style: GoogleFonts.interTight(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                            TextSpan(
                              text: ' Privacy Policy',
                              style: GoogleFonts.interTight(
                                color: Theme.of(context).brightness == Brightness.dark 
                                    ? Colors.grey.shade500 // Dark mode color
                                    : Colors.grey.shade800,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' to learn how we collect, use, and share your data',
                              style: GoogleFonts.interTight(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),



              SizedBox(height: screenHeight*0.040,),

              Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool success = await confirmPassword();
                      if (success) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return LeaguePreferencePage();
                        }));
                      }
                    },

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
                      'Continue',
                      style: GoogleFonts.interTight(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
            ]
          ),
        ),
      ),
    );
  }
}