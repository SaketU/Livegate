import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullapp/intro_screens/onboardingPage.dart';
import 'package:fullapp/auth/passwordPage.dart';
import 'package:fullapp/screens/chatPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final FlutterSecureStorage storage = FlutterSecureStorage();

class LeaguePreferencePage extends StatefulWidget {
  @override
  _LeaguePreferencePageState createState() => _LeaguePreferencePageState();
}

class _LeaguePreferencePageState extends State<LeaguePreferencePage> {
  final List<Map<String, dynamic>> leagues = [
    {'name': 'NFL',},
    {'name': 'NBA', },
    {'name': 'MLB', },
    {'name': 'UFC', },
    {'name': 'NCAAF',},
    {'name': 'NCAA BSK',},
    {'name': 'NCAA BASE',}, //baseball
    {'name': 'NHL',},
    {'name': 'Soccer',},
    {'name': 'F1',},
    {'name': 'Tennis',},
  ];

  List<String> selectedleagues = [];

  void toggleSelection(String interest) {
    setState(() {
      if (selectedleagues.contains(interest)) {
        selectedleagues.remove(interest);
      } else {
        selectedleagues.add(interest);
      }
    });
  }

  // Function to send the selected leagues to the backend using the stored token.
  Future<void> setLeaguePreferences() async {
  final token = await storage.read(key: 'accessToken');
  if (token == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("No access token found. Please log in again.")),
    );
    return;
  }

  final url = Uri.parse('http://localhost:8000/set-leagues'); // Adjust URL if needed.
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'leagues': selectedleagues}),
    );

    if (response.statusCode == 200) {
      // Navigate to OnBoardingPage after successful update.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OnBoardingPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update league preferences.")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
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
          'Preferences',
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
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.025),
              Text(
                "Choose your leagues",
                style: GoogleFonts.interTight(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight*0.005),
              Text(
                "Which leagues do you follow the most?",
                style: GoogleFonts.interTight(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: screenHeight*0.05),
              SingleChildScrollView( // This should wrap the Column, not just Wrap
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
        spacing: 15,
        runSpacing: 15,
        alignment: WrapAlignment.start, // Ensures items are aligned better
        children: leagues.map((interest) {
          bool isSelected = selectedleagues.contains(interest['name']);
          return GestureDetector(
            onTap: () => toggleSelection(interest['name']),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 30),
              decoration: BoxDecoration(
                color: isSelected 
                    ? Colors.black 
                    : Theme.of(context).brightness == Brightness.dark
                        ? Colors.white10
                        : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                interest['name'],
                style: GoogleFonts.interTight(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isSelected 
                      ? Colors.white 
                      : Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
      SizedBox(height: 20), // Prevents cutting off at the bottom
    ],
  ),
),

              
              Spacer(),

              ElevatedButton(
                onPressed: selectedleagues.isNotEmpty ? () async {
                  await setLeaguePreferences();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnBoardingPage()),
                  );
                } : null,
                  style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.blue
                    : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Next",
                  style: GoogleFonts.interTight(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
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