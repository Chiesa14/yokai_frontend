import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:yokai_quiz_app/Widgets/splash_screen.dart';
import 'package:yokai_quiz_app/global.dart';

// SharedPreferences? prefs;
// const String appName = "B.AI";

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  // systemNavigationBarColor: Colors.blue, // navigation bar color
  //   statusBarColor: Colors.transparent, // status bar color
  // ));
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDqtImJuX5KXz3woxkhpWTbTiTkU2J-W8U",
            projectId: "yokaizen-43f63",
            messagingSenderId: "543257928924",
            appId: "1:543257928924:android:b374bd4fc856d39e08c019"));
  } else {
    await Firebase.initializeApp();
  }
  prefs = await SharedPreferences.getInstance();

  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

late SharedPreferences prefs;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    checkDebugMode();
    return GetMaterialApp(
        theme: ThemeData(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        // color: appColor,
        // home: TopicalExam_page(subjectName: "History",));
        home: const SplashScreen());
  }
}
