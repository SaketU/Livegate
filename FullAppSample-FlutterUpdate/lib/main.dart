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


