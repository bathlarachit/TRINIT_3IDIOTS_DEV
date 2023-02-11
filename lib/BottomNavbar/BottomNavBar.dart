// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../Community/CommunityLandingPage.dart';
import '../Home/HomePage.dart';
import '../Modal/Staticfile.dart';

class BottomNavbar {
  Widget navbar(context){
    return GNav(
          selectedIndex: Staticfile.navIndex,
          onTabChange: (index) {},
          activeColor: Colors.blue,
          gap: 20,
          tabs:  [
            GButton(
              icon: Icons.home,
              text: 'Home', 
              onPressed: (){
                Staticfile.navIndex=0;
                Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),(Route<dynamic> route) => false);
              },
            ),
            GButton(
              icon: Icons.bookmark,
              text: 'Funding',
              onPressed: (){
                Staticfile.navIndex=1;
                Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),(Route<dynamic> route) => false);
              }, 
            ),
            GButton(
              icon: Icons.feed,
              text: 'Community',
              onPressed: (){
                Staticfile.navIndex=2;
                Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => CommunityLandingPage()),(Route<dynamic> route) => false);
              },
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
              onPressed: (){
                Staticfile.navIndex=3;
                Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),(Route<dynamic> route) => false);
              },
            ),
          ],
        );
  }
}