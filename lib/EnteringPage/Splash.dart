import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trinit/Home/HomePage.dart';

import '../constants.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedSplashScreen(
        duration: 3000,
        splashIconSize: 200,
        //  centered: true,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: const HomePage(),
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
