// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trinit/Backend/GetUserDetails.dart';
import 'package:trinit/BottomNavbar/BottomNavBar.dart';
import 'package:trinit/Modal/Staticfile.dart';
import 'package:trinit/components/list.dart';

import '../EnteringPage/Splash.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
        title:
        Padding(
          padding: EdgeInsets.only(bottom:10, top: 10) ,
        child:  SizedBox(
          
          child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Image(
                    height: 70,
                    width: 70,
                    image: AssetImage('assets/images/man.png'),
                  ),
                  Column(
                    children:[
                      Text(
                        "Welcome Back ${Staticfile.name}",
                        style: TextStyle(color: Colors.black,
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Sunday, 12 Febraury',style: TextStyle(color: Colors.black,
                            fontSize: 18, fontWeight: FontWeight.bold),),
                      ),
                    ],
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
        )),
        backgroundColor: Color(0xFFd8f2fd),
      ),
      resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomNavbar().navbar(context),
        body: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // const Card(
              //   elevation: 0,
              //   child: ListTile(
              //     leading: Image(
              //       image: AssetImage('assets/images/man.png'),
              //     ),
              //     title: Text(
              //       'Welcome Back!',
              //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //     ),
              //     subtitle: Text('Sunday, 12 Febraury'),
              //   ),
              // ),

              Row(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        constraints: BoxConstraints(maxWidth: 280),
                        focusedBorder: OutlineInputBorder(),
                        hintText: "Search for NGO's....",
                        border: InputBorder.none),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    height: 60,
                    width: 60,
                    child: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const CardList()
            ],
          ),
        ),
      ),
    );
  }
}
