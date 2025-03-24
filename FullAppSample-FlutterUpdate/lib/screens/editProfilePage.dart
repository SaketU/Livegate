import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:image_picker/image_picker.dart';
//code
class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final profileImage =
      'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?cs=srgb&dl=pexels-mohamed-abdelghaffar-771742.jpg&fm=jpg';
      File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  late TextEditingController _usernameController;
  final String prefix = "@";

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: "@currentusername");

    _usernameController.addListener(() {
      if (!_usernameController.text.startsWith(prefix)) {
        _usernameController.text = "$prefix${_usernameController.text.replaceAll(prefix, '')}";
        _usernameController.selection = TextSelection.fromPosition(
          TextPosition(offset: _usernameController.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
                onTap: () => Navigator.pop(context),
                child: Text(
                  "Done",
                  style: GoogleFonts.interTight(
                    fontSize: screenHeight * 0.019,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
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
              padding: EdgeInsets.only(left: 21.0, right: 21, top: screenHeight*0.0296, bottom: screenHeight*0.02),
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
                        controller: TextEditingController(text: 'currentname'),
                        cursorColor: Theme.of(context).colorScheme.tertiary,
                        readOnly: false,
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
              padding: EdgeInsets.only(left: 21.0, right: 21, bottom: screenHeight*0.02),
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
              padding: EdgeInsets.only(left: 21.0, right: 21, bottom: screenHeight*0.02),
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
                        controller: TextEditingController(text: 'current user bio'),
                        cursorColor: Theme.of(context).colorScheme.tertiary,
                        readOnly: false,
                        style: GoogleFonts.interTight(
                          fontSize: screenHeight * 0.018,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add a bio to your profile',
                          hintStyle: GoogleFonts.interTight(fontSize: 15, color: Colors.grey),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 21.0, right: 21, bottom: screenHeight*0.02),
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
                        controller: TextEditingController(text: 'Team • Team • Team'),
                        cursorColor: Theme.of(context).colorScheme.tertiary,
                        readOnly: false,
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
