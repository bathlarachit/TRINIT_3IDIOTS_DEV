import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BottomNavbar/BottomNavBar.dart';
import '../EnteringPage/Splash.dart';
import '../modal/Staticfile.dart';

class CreateCommunity extends StatefulWidget {
  const CreateCommunity({super.key});

  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {
  FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseDatabase db = FirebaseDatabase.instance;
    String motto="",domain="",plink="";
    bool load1=false;
  @override
  Widget build(BuildContext context) {
    
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
                          image: const DecorationImage(
                              image: AssetImage("assets/images/logo.png"))),
                    ),
                    Text(
                      "Create Community",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * (0.05),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(const EdgeInsets.all(10)),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 255, 255, 255)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                      onPressed: () async {
                        try {
                          Staticfile.navIndex = 0;
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
            bottomNavigationBar: BottomNavbar().navbar(context),


        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height-150),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                          
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: TextField(
                                onChanged: (value) {
                                  domain = value;
                                },
                                style: const TextStyle(fontSize: 17),
                                decoration: InputDecoration(
                                  //isDense: true,
                                  contentPadding: const EdgeInsets.only(
                                      left: 25, top: 10, bottom: 10, right: 20),
                                  labelText: 'Enter Domain of Work',
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: const Color(0xFFd8f2fd),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.teal.shade300,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: TextField(
                                onChanged: (value) {
                                  motto = value;
                                },
                                style: const TextStyle(fontSize: 17),
                                decoration: InputDecoration(
                                  //isDense: true,
                                  contentPadding: const EdgeInsets.only(
                                      left: 25, top: 10, bottom: 10, right: 20),
                                  labelText: 'Enter Motto of Community',
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: const Color(0xFFd8f2fd),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.teal.shade300,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: TextField(
                                onChanged: (value) {
                                  plink = value;
                                },
                                style: const TextStyle(fontSize: 17),
                                decoration: InputDecoration(
                                  //isDense: true,
                                  contentPadding: const EdgeInsets.only(
                                      left: 25, top: 10, bottom: 10, right: 20),
                                  labelText: 'Enter community photo url',
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: const Color(0xFFd8f2fd),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.teal.shade300,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            
                            
                            const SizedBox(
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
                                                      const EdgeInsets.all(15)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color.fromARGB(255, 255, 124, 124)) ,
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ))),
                                          onPressed: () async {
                                            setState(() {
                                              load1=true;
                                            });
                                            String z = db.ref().push().key.toString();
                                            print(motto+domain+plink);
                                            await db.ref("Community/$z/").set({
                                              "motto":motto,
                                              "domain":domain,
                                              "photo":plink
                                            });
                                            setState(() {
                                              load1=false;
                                              motto="";
                                              domain="";
                                              plink="";
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Text(
                                            "Create",
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ))
                                    :  const CircularProgressIndicator(),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                               
                              ],
                            ),
                          ],
                        )
                      
                    ))));
  }
}