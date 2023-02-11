// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'otpbody.dart';

import '../modal/Users.dart';

class OtpScreen extends StatelessWidget {
  Users u = Users();
  OtpScreen(Users us) {
    u = us;
  }
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "OTP Verification",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xff27C1C1),
      ),
      body: Otp(u),
    );
  }
}
