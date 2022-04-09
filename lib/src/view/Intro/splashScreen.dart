import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/src/controller/helper/myTheme.dart';
import 'package:fluttertest/src/view/mainScreen.dart';
import 'package:fluttertest/src/view/authintication/logInScreen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  bool? firstOpen;

  checkIfLoggedIn() async {
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      FirebaseAuth.instance.currentUser != null
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MainScreen()))
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LogInScreen()));
    });
  }

  @override
  void initState() {
    checkIfLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Text("Chat", style: MyTheme.styleBlackBold),
              ))
        ],
      ),
    );
  }
}
