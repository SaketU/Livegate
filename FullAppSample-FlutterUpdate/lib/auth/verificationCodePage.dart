import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fullapp/auth/passwordPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fullapp/models/square_tile.dart';
import 'package:flutter/services.dart';
import 'package:fullapp/auth/passwordPage.dart';

//code
class VerificationCodePage extends StatefulWidget {
  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final String fullName = "Your Full Name"; // Define the fullName variable
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final TextEditingController _emailController = TextEditingController(); // Define the _emailController

  ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_checkFields);
    }
  }

  void _checkFields() {
    bool allFilled = _controllers.every((controller) => controller.text.isNotEmpty);
    isButtonEnabled.value = allFilled;
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
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
                  "Verification code",
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
                  'Enter or paste the verification code here',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.interTight(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: screenWidth * 0.1205,
                          child: TextFormField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            cursorColor: Theme.of(context).colorScheme.tertiary,
                            style: GoogleFonts.interTight(fontSize: 20, fontWeight: FontWeight.bold),
                            enableInteractiveSelection: false, // Prevents handles from showing
                            showCursor: true, // Ensures cursor remains visible
                            decoration: InputDecoration(
                              counterText: "",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade400, width: 2.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade400, width: 2.0),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade400, width: 2.0),
                              ),
                            ),
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                if (index < 5) {
                                  _focusNodes[index + 1].requestFocus();
                                }
                              } else {
                                // Move focus back when deleting
                                if (index > 0) {
                                  _focusNodes[index - 1].requestFocus();
                                }
                                _controllers[index].clear(); // Ensure no character is displayed
                              }
                              _checkFields();
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Resend code',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.interTight(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  )),
              Spacer(),
              ValueListenableBuilder<bool>(
                valueListenable: isButtonEnabled,
                builder: (context, isEnabled, child) {
                  return Container(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: isEnabled
                          ? () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PasswordPage(
                                    fullName: fullName,  // pass your actual full name here
                                    email: _emailController.text.trim(),  // pass your actual email here
                                ),
                              ),
                            );
                            }
                          : null, // Disable button when empty
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEnabled
                            ? Colors.black
                            : Colors.grey.shade400, // Dynamic color change
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*
class VerificationCodePage extends StatefulWidget{
  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}
class _VerificationCodePageState extends State<VerificationCodePage> {

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
    double screenHeight = MediaQuery.of(context).size.height;
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
    padding: EdgeInsets.zero, // Removes unnecessary padding
    constraints: BoxConstraints(), // Removes extra constraints
  ),
),

      body: SafeArea(
        top: false,
        bottom: true,
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
        
          children: [ 

            SizedBox(height: screenHeight * 0.015),

            Align(
              alignment: Alignment.topLeft,
              child: Text("Verificaton code", textAlign: TextAlign.start,style: GoogleFonts.interTight(color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.bold, fontSize: 22,),
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Enter or paste the verification code here', textAlign: TextAlign.start, style: GoogleFonts.interTight(color: Colors.grey.shade600, fontSize: 13,),
                  ),
            ),
            
            SizedBox(height: screenHeight * 0.005),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 40,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: GoogleFonts.interTight(fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        counterText: "", // Hide character count
                        //border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus(); // Move to the next field
                        }
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/