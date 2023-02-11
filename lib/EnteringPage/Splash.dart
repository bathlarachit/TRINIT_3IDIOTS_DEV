// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trinit/Home/HomePage.dart';

import '../Auth/Login.dart';
import '../constants.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    auth.currentUser != null ? HomePage() : SignIn())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedSplashScreen(
        duration: 3000,
        splashIconSize: 200,
        //  centered: true,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: HomePage(),
        splash: SizedBox(
          height: 450,
          width: 350,
          child: ListView(
            children: [
              const Image(
                height: 120,
                image: AssetImage('assets/images/read.png'),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Blogesta",
                    style: GoogleFonts.permanentMarker(
                        color: colour, fontSize: 32),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
