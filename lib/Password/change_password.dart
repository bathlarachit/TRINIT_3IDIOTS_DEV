// // ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, sized_box_for_whitespace, file_names, camel_case_types

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:rythuvaani/Model_class/staticfile.dart';

// String alert = "";
// FirebaseAuth auth = FirebaseAuth.instance;

// class changePass extends StatefulWidget {
//   const changePass({Key? key}) : super(key: key);

//   @override
//   State<changePass> createState() => _changePassState();
// }

// class _changePassState extends State<changePass> {
//   bool load = false;
//   String new_pass = "", match_pass = "", pass = "";
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async {
//           Navigator.pop(context);
//           return true;
//         },
//         child: Scaffold(
//             resizeToAvoidBottomInset: false,
//             appBar: AppBar(
//                   title: Text(
//                     Staticfile.ch_pass[Staticfile.lang_code],
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                   centerTitle: true,
//                   leading: IconButton(
//                     icon: Icon(Icons.arrow_back),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   backgroundColor: Color(0xff27C1C1),
//                 ),
//             body: SafeArea(
//                 child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Reset Password",
//                   style: GoogleFonts.roboto(color: Colors.black, fontSize: 20),
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width - 40,
//                   child: TextField(
//                     obscureText: true,
//                     onChanged: (value) {
//                       pass = value;
//                     },
//                     style: TextStyle(fontSize: 17),
//                     decoration: InputDecoration(
//                       //isDense: true,
//                       contentPadding: EdgeInsets.only(
//                           left: 25, top: 10, bottom: 10, right: 20),
//                       labelText: 'Current Password',
//                       border: InputBorder.none,
//                       filled: true,
//                       fillColor: Colors.teal.shade50,
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.teal.shade300,
//                           width: 2.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width - 40,
//                   child: TextField(
//                     obscureText: true,
//                     onChanged: (value) {
//                       new_pass = value;
//                       if (match_pass != "" && value != match_pass) {
//                         setState(() {
//                           alert = "Passwords doesn't match!!";
//                         });
//                       } else {
//                         setState(() {
//                           alert = "";
//                         });
//                       }
//                     },
//                     style: TextStyle(fontSize: 17),
//                     decoration: InputDecoration(
//                       //isDense: true,
//                       contentPadding: EdgeInsets.only(
//                           left: 25, top: 10, bottom: 10, right: 20),
//                       labelText: 'New Password',
//                       border: InputBorder.none,
//                       filled: true,
//                       fillColor: Colors.teal.shade50,
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.teal.shade300,
//                           width: 2.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width - 40,
//                   child: TextField(
//                     onChanged: (value) {
//                       match_pass = value;
//                       if (value != "" && value != new_pass) {
//                         setState(() {
//                           alert = "Passwords doesn't match!!";
//                         });
//                       } else {
//                         setState(() {
//                           alert = "";
//                         });
//                       }
//                     },
//                     obscureText: true,
//                     style: TextStyle(fontSize: 17),
//                     decoration: InputDecoration(
//                       //isDense: true,
//                       contentPadding: EdgeInsets.only(
//                           left: 25, top: 10, bottom: 10, right: 20),
//                       labelText: 'Confirm Password',
//                       border: InputBorder.none,
//                       filled: true,
//                       fillColor: Colors.teal.shade50,
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.teal.shade300,
//                           width: 2.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Text(
//                   alert,
//                   style: TextStyle(color: Colors.redAccent, fontSize: 12),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     load == false
//                         ? Container(
//                             width: MediaQuery.of(context).size.width - 40,
//                             // color: Colors.red,
//                             child: ElevatedButton(
//                               style: ButtonStyle(
//                                   padding: MaterialStateProperty.all(
//                                       EdgeInsets.all(15)),
//                                   backgroundColor: MaterialStateProperty.all(
//                                       Color(0xff27C1C1)),
//                                   shape: MaterialStateProperty.all(
//                                       RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5),
//                                   ))),
//                               onPressed: () async {
//                                 setState(() {
//                                   load = true;
//                                 });
//                                 AuthCredential credential =
//                                     EmailAuthProvider.credential(
//                                         email:
//                                             auth.currentUser!.email.toString(),
//                                         password: pass);
//                                 try {
//                                   await auth.currentUser!
//                                       .reauthenticateWithCredential(credential);
//                                 } on FirebaseAuthException catch (e) {
//                                   Fluttertoast.showToast(
//                                       msg: e.message.toString());
//                                   setState(() {
//                                     load = false;
//                                   });
//                                   return;
//                                 }
//                                 if (match_pass != new_pass) {
//                                   setState(() {
//                                     alert = "Passwords doesn't match!!";
//                                     return;
//                                   });
//                                 }
//                                 await auth.currentUser!
//                                     .updatePassword(new_pass);
//                                 setState(() {
//                                   load = false;
//                                 });
//                                 Fluttertoast.showToast(
//                                     msg: "Password Changed!!!");
//                                 Navigator.pop(context);
//                               },
//                               child: Text(
//                                 "Confirm Changes",
//                                 style: GoogleFonts.roboto(
//                                   color: Colors.white,
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ))
//                         : CircularProgressIndicator(),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 150,
//                 )
//               ],
//             ))));
//   }
// }
