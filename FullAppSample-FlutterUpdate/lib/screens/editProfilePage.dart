import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final storage = FlutterSecureStorage();
  final profileImage =
      'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?cs=srgb&dl=pexels-mohamed-abdelghaffar-771742.jpg&fm=jpg';
  File? _selectedImage;
  bool isLoading = true;
  bool isSaving = false;

  late TextEditingController _usernameController;
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _teamsController;

  final String prefix = "@";

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _nameController = TextEditingController();
    _bioController = TextEditingController();
    _teamsController = TextEditingController();

    _usernameController.addListener(() {
      if (!_usernameController.text.startsWith(prefix)) {
        _usernameController.text =
            "$prefix${_usernameController.text.replaceAll(prefix, '')}";
        _usernameController.selection = TextSelection.fromPosition(
          TextPosition(offset: _usernameController.text.length),
        );
      }
    });

    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final token = await storage.read(key: 'accessToken');
      if (token == null) throw Exception('No access token found');

      final response = await http.get(
        Uri.parse('http://localhost:8000/api/user/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _nameController.text = data['fullName'] ?? '';
          _usernameController.text = '@${data['username'] ?? ''}';
          _bioController.text = data['bio'] ?? '';
          _teamsController.text =
              (data['leaguePreferences'] as List?)?.join(' • ') ?? '';
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error loading user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load profile data')),
      );
      setState(() => isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    try {
      setState(() => isSaving = true);
      final token = await storage.read(key: 'accessToken');
      if (token == null) throw Exception('No access token found');

      final response = await http.post(
        Uri.parse('http://localhost:8000/api/user/update-profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'fullName': _nameController.text,
          'username': _usernameController.text.replaceAll('@', ''),
          'bio': _bioController.text,
          'leaguePreferences': _teamsController.text.split(' • '),
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
        Navigator.pop(context, true); // Pass true to indicate successful update
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Failed to update profile');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => isSaving = false);
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _bioController.dispose();
    _teamsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    if (isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: GoogleFonts.interTight(
                    fontSize: screenHeight * 0.019,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Edit Profile',
                style: GoogleFonts.interTight(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.019,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: isSaving ? null : _saveProfile,
                child: Text(
                  isSaving ? "Saving..." : "Done",
                  style: GoogleFonts.interTight(
                    fontSize: screenHeight * 0.019,
                    fontWeight: FontWeight.bold,
                    color: isSaving
                        ? Colors.grey
                        : Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: MediaQuery.of(context).size.width * 0.23,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : NetworkImage(profileImage) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.0142),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Text(
                      'Edit profile picture',
                      style: GoogleFonts.interTight(
                        fontWeight: FontWeight.w700,
                        fontSize: screenHeight * 0.016,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 21.0,
                  right: 21,
                  top: screenHeight * 0.0296,
                  bottom: screenHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: GoogleFonts.interTight(
                      fontWeight: FontWeight.w500,
                      fontSize: screenHeight * 0.018,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: _nameController,
                        cursorColor: Theme.of(context).colorScheme.tertiary,
                        style: GoogleFonts.interTight(
                          fontSize: screenHeight * 0.018,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 21.0, right: 21, bottom: screenHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: GoogleFonts.interTight(
                      fontWeight: FontWeight.w500,
                      fontSize: screenHeight * 0.018,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: _usernameController,
                        cursorColor: Theme.of(context).colorScheme.tertiary,
                        style: GoogleFonts.interTight(
                          fontSize: screenHeight * 0.018,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 21.0, right: 21, bottom: screenHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Bio',
                    style: GoogleFonts.interTight(
                      fontWeight: FontWeight.w500,
                      fontSize: screenHeight * 0.018,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: _bioController,
                        cursorColor: Theme.of(context).colorScheme.tertiary,
                        style: GoogleFonts.interTight(
                          fontSize: screenHeight * 0.018,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add a bio to your profile',
                          hintStyle: GoogleFonts.interTight(
                              fontSize: 15, color: Colors.grey),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 21.0, right: 21, bottom: screenHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Teams',
                    style: GoogleFonts.interTight(
                      fontWeight: FontWeight.w500,
                      fontSize: screenHeight * 0.018,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: _teamsController,
                        cursorColor: Theme.of(context).colorScheme.tertiary,
                        style: GoogleFonts.interTight(
                          fontSize: screenHeight * 0.018,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
