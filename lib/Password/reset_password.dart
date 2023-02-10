// // ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, sized_box_for_whitespace, file_names, camel_case_types

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:rythuvaani/Backend/LocationB.dart';
// import 'package:rythuvaani/Model_class/staticfile.dart';
// import 'package:rythuvaani/Model_class/users.dart';
// import 'package:rythuvaani/screens/Admin/NavBarA.dart';
// import 'package:rythuvaani/screens/EnteringPage/FirstPage.dart';
// import 'package:rythuvaani/screens/Farmer/NavBarF.dart';
// import 'package:rythuvaani/screens/Scientist/NavBarS.dart';

// String alert = "";
// Users u = Users();
// FirebaseAuth auth = FirebaseAuth.instance;

// class resetPass extends StatefulWidget {
//   resetPass(user) {
//     u = user;
//   }

//   @override
//   State<resetPass> createState() => _resetPassState();
// }

// class _resetPassState extends State<resetPass> {
//   bool load = false;
//   String new_pass = "", match_pass = "";
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async {
//           Fluttertoast.showToast(msg: "Password Not Changed");
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (context) => HomePage()));
//           return true;
//         },
//         child: Scaffold(
//             resizeToAvoidBottomInset: false,
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
//                       new_pass = value;
//                       if (match_pass != "" && value != match_pass) {
//                         setState(() {
//                           alert = "Passwords doesn't match!!";
//                         });
//                       } else if (new_pass.length < 5) {
//                         setState(() {
//                           alert = "Password must be atleast 6 characters long";
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

//                                 if (match_pass != new_pass) {
//                                   setState(() {
//                                     alert = "Passwords doesn't match!!";
//                                     return;
//                                   });
//                                 }
//                                 await auth.currentUser!
//                                     .updatePassword(new_pass);

//                                 Fluttertoast.showToast(
//                                     msg: "Password Changed!!!");
//                                 if (u.getStatus() == "Farmer") {
//                                   var loc;
//                                   var p = await LocationB().getper();
//                                   if (p) {
//                                     loc = await LocationB().getloc();
//                                     double dist = Geolocator.distanceBetween(
//                                         double.parse(Staticfile.latitude),
//                                         double.parse(Staticfile.longitude),
//                                         double.parse(loc.latitude.toString()),
//                                         double.parse(loc.longitude.toString()));
//                                     setState(() {
//                                       load = false;
//                                     });
//                                     //print(dist.toString());
//                                     dist = dist / 1000;
//                                     if (dist > double.parse(Staticfile.rad)) {
//                                       Fluttertoast.showToast(
//                                           msg: "Out of Radius!!!!",
//                                           toastLength: Toast.LENGTH_LONG);
//                                       await auth.signOut();

//                                       Navigator.pushAndRemoveUntil(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) => HomePage()),
//                                           (Route<dynamic> route) => false);
//                                     }
//                                   } else {
//                                     setState(() {
//                                       load = false;
//                                     });
//                                     Fluttertoast.showToast(
//                                         msg: Staticfile.permission_error[
//                                                 Staticfile.lang_code] +
//                                             "!!");
//                                     await auth.signOut();
//                                     Navigator.pushAndRemoveUntil(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => HomePage()),
//                                         (Route<dynamic> route) => false);
//                                     return;
//                                   }
//                                   setState(() {
//                                     load = false;
//                                   });
//                                   Navigator.pushAndRemoveUntil(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               StartFarmerHome()),
//                                       (Route<dynamic> route) => false);
//                                 } else if (u.getStatus() == "Admin") {
//                                   setState(() {
//                                     load = false;
//                                   });
//                                   Navigator.pushAndRemoveUntil(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               StartAdminHome()),
//                                       (Route<dynamic> route) => false);
//                                 } else if (u.getStatus() == "Scientist") {
//                                   setState(() {
//                                     load = false;
//                                   });
//                                   Navigator.pushAndRemoveUntil(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               StartScientistHome()),
//                                       (Route<dynamic> route) => false);
//                                 } else {
//                                   setState(() {
//                                     load = false;
//                                   });
//                                   Fluttertoast.showToast(
//                                       msg: "Account in Verification Stage!!",
//                                       toastLength: Toast.LENGTH_LONG);
//                                   Staticfile().reset();
//                                   await auth.signOut();
//                                   Navigator.pop(context);
//                                 }
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
