import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:fullapp/themes/light_theme.dart';
import 'package:fullapp/themes/dark_theme.dart';// Import dark theme
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;
  bool _isDarkMode;

  ThemeProvider(this._themeData, this._isDarkMode);

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme(bool isDark) async {
    _isDarkMode = isDark;
    _themeData = isDark ? darkTheme : lightTheme;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark); // Save theme preference
  }

  static Future<ThemeProvider> create() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false; // Load theme preference
    return ThemeProvider(isDarkMode ? darkTheme : lightTheme, isDarkMode);
  }
}

class DisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Display Mode',
          style: GoogleFonts.interTight(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.bold,
            fontSize: screenHeight * 0.021,
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
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildThemeOption(context, 'assets/lightMode.svg', 'Light', false, !isDarkMode),
              SizedBox(width: screenWidth * 0.1),
              _buildThemeOption(context, 'assets/darkMode.svg', 'Dark', true, isDarkMode),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, String assetPath, String label, bool isDark, bool isSelected) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Provider.of<ThemeProvider>(context, listen: false).toggleTheme(isDark);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
            child: SvgPicture.asset(
              assetPath,
              height: screenHeight * 0.3,
            ),
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          SizedBox(height: 5),
          Icon(
            isSelected ? CupertinoIcons.checkmark_circle_fill : CupertinoIcons.circle,
            color: isSelected ? Colors.blue : Colors.grey,
            size: 24,
          ),
        ],
      ),
    );
  }
}
