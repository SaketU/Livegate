import 'package:flutter/foundation.dart';
import 'package:fullapp/firebase_options.dart';
import 'package:fullapp/auth/main_page.dart';
import 'package:fullapp/screens/displayPage.dart';
import 'package:fullapp/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:fullapp/auth/loginPage.dart';
import 'package:fullapp/screens/exProfilePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fullapp/themes/dark_theme.dart';
import 'package:fullapp/themes/light_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


//code
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ThemeProvider themeProvider = await ThemeProvider.create(); // Load saved theme

  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enable device preview in debug mode
      builder: (context) => ChangeNotifierProvider.value(
        value: themeProvider, // Provide the loaded theme
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          title: 'Flutter Demo',
          theme: themeProvider.themeData, // Apply saved theme
          debugShowCheckedModeBanner: false,
          home: MainPage(),
        );
      },
    );
  }
}

//old original 
/*
import 'package:flutter/foundation.dart';
import 'package:fullapp/firebase_options.dart';
import 'package:fullapp/auth/main_page.dart';
import 'package:fullapp/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:fullapp/auth/loginPage.dart';
import 'package:fullapp/screens/exProfilePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fullapp/themes/dark_theme.dart';
import 'package:fullapp/themes/light_theme.dart';
//code
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,//true,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
*/