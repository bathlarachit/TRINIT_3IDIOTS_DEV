// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trinit/Backend/GetUserDetails.dart';
import 'package:trinit/EnteringPage/Splash.dart';
import 'package:trinit/Home/HomePage.dart';
import '../modal/Users.dart';
import 'OtpF.dart';

String v = "";

class Otp extends StatefulWidget {
  Users user = Users();
  String otp = "";
  Otp(Users u) {
    v = "";
    user = u;
  }

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  bool load = true;
  int load1 = 0;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseDatabase db = FirebaseDatabase.instance;

    auth.verifyPhoneNumber(
        phoneNumber: widget.user.phn,
        verificationCompleted: (PhoneAuthCredential cred) async {
          if (widget.user.name != "") {
            await auth.createUserWithEmailAndPassword(
                email: widget.user.email, password: widget.user.pass);
            try {
              await auth.currentUser!.linkWithCredential(cred);
            } on FirebaseException catch (e) {
              print(e.message);
            }
            String uid = auth.currentUser!.uid;
            if (widget.user.status=="NGO") {
              await db.ref().child("Ngo").child(uid).set(<String, Object>{
                "name": widget.user.name,
                "phone": widget.user.phn,
                "mail": widget.user.email,
                "verified":false
              });
            } else {
              await db.ref().child("Users").child(uid).set(<String, Object>{
                "name": widget.user.name,
                "phone": widget.user.phn,
                "mail": widget.user.email
              });
            }

            await db
                .ref()
                .child("Phone_Mail")
                .child(widget.user.phn)
                .set(widget.user.email);

            await db
                .ref()
                .child("AccountType")
                .child(uid)
                .set(widget.user.status); 
            
            if(widget.user.status=="NGO") {
              Fluttertoast.showToast(
                  msg: "Account in Verification Stage!!",
                  toastLength: Toast.LENGTH_LONG);
              await auth.signOut();
              Navigator.pop(context);
              return;
            }
            GetUserDetails().getUserDetails(widget.user.status);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Splash()),
              (Route<dynamic> route) =>
                  false);
          // } else {
          //   await auth.signInWithCredential(cred);
          //   Users u = await getuser().GetUser();
          //   Navigator.pushAndRemoveUntil(
          //                                       context,
          //                                       MaterialPageRoute(
          //                                           builder: (context) =>
          //                                               resetPass(u)),
          //                                       (Route<dynamic> route) =>
          //                                           false);
          }

          
        },
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(
              msg: e.message.toString(), toastLength: Toast.LENGTH_LONG);

          Navigator.pop(context);
        },
        codeSent: (String verificationid, int? token) {
          setState(() {
            v = verificationid;
            load = false;
          });
          Fluttertoast.showToast(msg: "OTP sent");
        },
        codeAutoRetrievalTimeout: (String verid) {});

    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Splash()));
          return true;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(onTap: () {}, child: SizedBox()),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.png")),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Verification',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Enter your OTP code number",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Container(
                      padding: EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: load == false
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _textFieldOTP(first: true, last: false),
                                    _textFieldOTP(first: false, last: false),
                                    _textFieldOTP(first: false, last: false),
                                    _textFieldOTP(first: false, last: false),
                                    _textFieldOTP(first: false, last: false),
                                    _textFieldOTP(first: false, last: true),
                                  ],
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                load1 == 0
                                    ? SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              load1 = 1;
                                            });
                                            PhoneAuthCredential cr;
                                            try {
                                              cr = PhoneAuthProvider.credential(
                                                  verificationId: v,
                                                  smsCode: widget.otp);

                                              if (widget.user.name != "") {
                                                await auth
                                                    .createUserWithEmailAndPassword(
                                                        email: widget.user.email,
                                                        password: widget
                                                            .user.pass);
                                                await auth.currentUser!
                                                    .linkWithCredential(cr);
                                                String uid =
                                                    auth.currentUser!.uid;
                                                if (widget
                                                        .user.status ==
                                                    "NGO") {
                                                  await db
                                                      .ref()
                                                      .child("Ngo")
                                                      .child(uid)
                                                      .set(<String, Object>{
                                                    "name": widget.user.name,
                                                    "phone": widget.user.phn,
                                                    "mail": widget.user.email,
                                                    "verified":false                                                    
                                                  });
                                                } else {
                                                  await db
                                                      .ref()
                                                      .child("Users")
                                                      .child(uid)
                                                      .set(<String, Object>{
                                                    "name": widget.user.name,
                                                    "phone": widget.user.phn,
                                                    "mail": widget.user.email,
                                                  });
                                                }

                                                await db
                                                    .ref()
                                                    .child("Phone_Mail")
                                                    .child(widget.user.phn)
                                                    .set(widget.user.email);
                                                await db
                                                    .ref()
                                                    .child("AccountType")
                                                    .child(uid)
                                                    .set(widget.user.status); 

                                                if (widget.user.status == "Ngo") {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Account in Verification Stage!!");
                                                  setState(() {
                                                    load1 = 0;
                                                  });
                                                  await auth.signOut();
                                                  Navigator.pop(context);
                                                  return;
                                                }
                                                GetUserDetails().getUserDetails(widget.user.status);
                                                Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Splash()),
                                                (Route<dynamic> route) =>
                                                    false);

                                              // } else {
                                              //   await auth
                                              //       .signInWithCredential(cr);
                                              //   Navigator.pushAndRemoveUntil(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           resetPass(u)),
                                              //   (Route<dynamic> route) =>
                                              //       false);
                                              }
                                            } on FirebaseException catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: e.message.toString());
                                              setState(() {
                                                load1 = 0;
                                              });
                                              Navigator.pop(context);
                                            }
                                          },
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    Colors.cyan.shade700),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                              ),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(14.0),
                                            child: Text(
                                              'Verify',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      )
                                    : CircularProgressIndicator()
                              ],
                            )
                          : CircularProgressIndicator(),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Didn't you receive any code?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpScreen(widget.user)));
                      },
                      child: Text(
                        "Resend New Code",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              )),
            )));
  }

  Widget _textFieldOTP({bool first = true, last}) {
    return SizedBox(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.45,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
            widget.otp += value;
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.green.shade700),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
