import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yokai_quiz_app/screens/Authentication/login_screen.dart';

import '../api/local_storage.dart';
import '../main.dart';
import '../screens/navigation/view/navigation.dart';

// import 'Authentication/login_screen.dart';
// import 'navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToNextScreen();
    super.initState();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));

    // bool isLoggedIn = prefs!.getBool(LocalStorage.isLogin) ?? false;
    // String email = prefs!.getString("email") ?? "";
    // print("isLogin :: ${prefs!.getBool(LocalStorage.isLogin)}");
    // print("isLoggedIn :: $isLoggedIn");
    // isLoggedIn
    //     ? Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    //         builder: (context) {
    //           return NavigationPage();
    //         },
    //       ), (route) => false)
    //     :
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return (prefs.getBool(LocalStorage.isLogin) == true)
            ? NavigationPage()
            : LoginScreen();
      },
    ), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF413B45),
              Color(0xFF1D1B26),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Image.asset('images/applogoBig_yokai.png'),
        ),
      ),
    );
  }
}
