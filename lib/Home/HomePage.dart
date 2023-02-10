// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../EnteringPage/Splash.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: kToolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                //margin: EdgeInsets.only(left: 50),
                height: MediaQuery.of(context).size.width * (0.1),
                width: MediaQuery.of(context).size.width * (0.1),
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("assets/logo.png"))),
              ),
              Text(
                "IEEE iSES 2022 Schedule",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * (0.05),
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 255, 255, 255)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
                onPressed: () async {
                  try {
                    await auth.signOut();
                    Fluttertoast.showToast(msg: "Signed Out");
                  } catch (e) {
                    Fluttertoast.showToast(msg: "Error Signing Out:-$e");
                  }
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Splash()),
                      (Route<dynamic> route) => false);
                },
                child: Text(
                  "Logout",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * (0.04),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Color(0xFFd8f2fd),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Text("Hello Nit")
          // SingleChildScrollView(
          //     child: ConstrainedBox(
          //         constraints: BoxConstraints(
          //             minHeight: MediaQuery.of(context).size.height - 100),
          //         child: Container(
          //             decoration: BoxDecoration(
          //                 gradient: LinearGradient(
          //               begin: Alignment.topRight,
          //               end: Alignment.bottomLeft,
          //               colors: const [
          //                 Color.fromARGB(255, 255, 255, 255),
          //                 Color.fromARGB(255, 187, 235, 255)
          //               ],
          //             )),
          //             child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 children: [
          //                   Container(
          //                     height: 80,
          //                     width: MediaQuery.of(context).size.width - 20,
          //                     // ignore: prefer_const_constructors
          //                     decoration: BoxDecoration(
          //                         image: DecorationImage(
          //                             image: AssetImage("assets/ieee.png"))),
          //                   ),
          //                   Container(
          //                     padding: EdgeInsets.all(15),
          //                     margin: EdgeInsets.all(15),
          //                     decoration: BoxDecoration(
          //                       gradient: LinearGradient(
          //                         begin: Alignment.centerLeft,
          //                         end: Alignment.centerRight,
          //                         colors: const [
          //                           Color.fromARGB(255, 255, 255, 255),
          //                           Color.fromARGB(255, 187, 235, 255)
          //                         ],
          //                       ),
          //                       boxShadow: [
          //                         BoxShadow(
          //                           color: Colors.grey.shade700,
          //                           offset: const Offset(8.0,5.0,),
          //                           blurRadius: 10.0,
          //                         ), //BoxShadow
          //                         BoxShadow(
          //                           color: Colors.white,
          //                           offset: const Offset(1.0, 0.0),
          //                           blurRadius: 0.0,
          //                           spreadRadius: 0.0,
          //                         ), //BoxShadow
          //                       ],
          //                       borderRadius:
          //                           BorderRadius.circular(15),
          //                     ),
          //                     child:Linkify(
          //                       onOpen: _onOpen,
          //                       text: "Link to Website:- https://ieee-ises.org/2022/",
          //                       textAlign: TextAlign.left,
          //                       style: GoogleFonts.roboto(
          //                         fontSize: MediaQuery.of(context).size.width*(0.04),
          //                         fontWeight: FontWeight.w500,
          //                         fontStyle:FontStyle.italic,
          //                       ),
          //                     )
          //                     ),
          //                   InkWell(
          //                     onTap: () {
          //                       Navigator.push(
          //                           context,
          //                           MaterialPageRoute(
          //                               builder: (context) => Day(d: "Day0")));
          //                     },
          //                     child: Mainbody(
          //                       heading: "Day 0",
          //                       subheading: "Date:- 18 Dec 2022",
          //                       subheading2: "Timing: 08:30 - 18:30 IST",
          //                       subheading3: "Lunch Break: 13:00 - 14:00 IST",
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 25,
          //                   ),
          //                   InkWell(
          //                     onTap: () {
          //                       Navigator.push(
          //                           context,
          //                           MaterialPageRoute(
          //                               builder: (context) => Day(d: "Day1")));
          //                     },
          //                     child: Mainbody(
          //                       heading: "Day 1",
          //                       subheading: "Date:- 19 Dec 2022",
          //                       subheading2: "Timing: 08:00 - 21:00 IST",
          //                       subheading3: "Lunch Break: 13:30 - 14:30 IST",
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 25,
          //                   ),
          //                   InkWell(
          //                     onTap: () {
          //                       Navigator.push(
          //                           context,
          //                           MaterialPageRoute(
          //                               builder: (context) => Day(d: "Day2")));
          //                     },
          //                     child: Mainbody(
          //                       heading: "Day 2",
          //                       subheading: "Date:- 20 Dec 2022",
          //                       subheading2: "Timing: 08:00 - 22:00 IST",
          //                       subheading3: "Lunch Break: 13:30 - 14:30 IST",
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 25,
          //                   ),
          //                   InkWell(
          //                     onTap: () {
          //                       Navigator.push(
          //                           context,
          //                           MaterialPageRoute(
          //                               builder: (context) => Day(d: "Day3")));
          //                     },
          //                     child: Mainbody(
          //                       heading: "Day 3",
          //                       subheading: "Date:- 21 Dec 2022",
          //                       subheading2: "Timing: 08:00 - 18:45 IST",
          //                       subheading3: "Lunch Break: 13:45 - 14:45 IST",
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 25
          //                   ),
          //                 ]))))
                          
                          ),
    );
  }
}
