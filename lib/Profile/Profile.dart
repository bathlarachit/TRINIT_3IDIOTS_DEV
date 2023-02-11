// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trinit/Modal/Staticfile.dart';

import '../BottomNavbar/BottomNavBar.dart';
import '../EnteringPage/Splash.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        const DecorationImage(image: AssetImage("assets/images/logo.png"))),
              ),
              Text(
                "Home",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * (0.05),
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 255, 255, 255)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
                onPressed: () async {
                  try {
                    Staticfile.navIndex=0;
                    await auth.signOut();
                    Fluttertoast.showToast(msg: "Signed Out");
                  } catch (e) {
                    Fluttertoast.showToast(msg: "Error Signing Out:-$e");
                  }
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Splash()),
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
        backgroundColor: const Color(0xFFd8f2fd),
      ),
      resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomNavbar().navbar(context),
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
                onTap: ()=>{
                  if(Staticfile.photo!=""){
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewImg(s.pic)))
                  }
                },
                child: 
                Staticfile.photo==""?
                Container(
                  height: MediaQuery.of(context).size.height * (0.25),
                  width: MediaQuery.of(context).size.width ,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    border: Border.all(width: 3, color: const Color.fromARGB(255, 60, 60, 60)),
                    image:const DecorationImage(image: AssetImage("assets/images/dog2.jpg"))
                  ))
                :
                Container(
                  height: MediaQuery.of(context).size.height * (0.25),
                  width: MediaQuery.of(context).size.width ,
                  decoration: BoxDecoration(
                        border: Border.all(width: 3, color: const Color.fromARGB(255, 60, 60, 60))),
                  child: Image.network(
                    Staticfile.photo,
                    fit: BoxFit.contain,
                    loadingBuilder: (BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null ) {
                        return child;
                      }
                      return Container(color: Colors.teal.shade100);
                    },
                  ),
                  )
              ),

          ],
        )
      ));
  }
}