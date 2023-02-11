// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trinit/EnteringPage/Splash.dart';

import '../../Backend/SignIn.dart';
import 'Register.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String mail = "", pass = "";
  bool load1 = false, load2 = false, load3 = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 59),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: TextField(
                                onChanged: (value) {
                                  mail = value;
                                },
                                style: TextStyle(fontSize: 17),
                                decoration: InputDecoration(
                                  //isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 25, top: 10, bottom: 10, right: 20),
                                  labelText: 'Enter Mail',
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color(0xFFd8f2fd),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.teal.shade300,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: TextField(
                                onChanged: (value) {
                                  pass = value;
                                },
                                obscureText: true,
                                style: TextStyle(fontSize: 17),
                                decoration: InputDecoration(
                                  //isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 25, top: 10, bottom: 10, right: 20),
                                  labelText: 'Enter Password',
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color(0xFFd8f2fd),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.teal.shade300,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                load1 == false
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        // color: Colors.red,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.all(15)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(0xff27C1C1)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ))),
                                          onPressed: () async {
                                            setState(() {
                                              load1 = true;
                                            });
                                            await SignsIn().signin(mail, pass);
                                            if (auth.currentUser != null) {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Splash()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                            } else {
                                              setState(() {
                                                load1 = false;
                                              });
                                            }
                                          },
                                          child: Text(
                                            "Login",
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ))
                                    : CircularProgressIndicator(),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            30,
                                    // color: Colors.red,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        //Forgot password button clicked
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Register()),
                                            (Route<dynamic> route) => false);
                                      },
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(15)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(0xff27C1C1)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ))),
                                      child: Text(
                                        "Register",
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context).size.width*(0.04),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  width: 25,
                                ),
                                load3 == false
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                30,
                                        // color: Colors.red,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            //Forgot password button clicked
                                            if (mail == "") {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Enter the registered mail");
                                              return;
                                            }
                                            setState(() {
                                              load3 = true;
                                            });
                                            try {
                                              await auth.sendPasswordResetEmail(
                                                  email: mail);
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Reset link sent to email");
                                            } catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: "Error:-$e");
                                            }
                                            setState(() {
                                              load3 = false;
                                            });
                                          },
                                          style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.all(15)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(0xff27C1C1)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ))),
                                          child: Text(
                                            "Forgot Password",
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context).size.width*(0.04),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ))
                                    : CircularProgressIndicator(),
                              ],
                            ),
                          ],
                        )
                      ],
                    )))));
  }
}
