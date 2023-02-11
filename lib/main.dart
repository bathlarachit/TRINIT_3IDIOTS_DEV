// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trinit/Home/HomePage.dart';
import 'package:trinit/Ngo/ngo_list.dart';

import 'Community/CommunityLandingPage.dart';
import 'EnteringPage/Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  CommunityLandingPage(),
      // routes: {
      //   "/": (context) =>  Splash(),
      //   '/home': (context) =>  HomePage(),
        '/NgoList':(context)=>NgoList()
      // },
    );
  }
}
