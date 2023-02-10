// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Backend/GoogleLogin.dart';
import '../../Backend/SignUp.dart';
import '../Home/HomePage.dart';
import 'Login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name = "", pass = "", mail = "";
  bool load = false, load2 = false;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Column(children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: TextField(
                        // controller: nameController,
                        onChanged: (value) {
                          name = value;
                        },
                        style: const TextStyle(fontSize: 17),
                        decoration: InputDecoration(
                          //isDense: true,
                          contentPadding: const EdgeInsets.only(
                              left: 25, top: 10, bottom: 10, right: 20),
                          labelText: 'Enter Name',
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
                        // controller: nameController,
                        onChanged: (value) {
                          mail = value;
                        },
                        style: const TextStyle(fontSize: 17),
                        decoration: InputDecoration(
                          //isDense: true,
                          contentPadding: const EdgeInsets.only(
                              left: 25, top: 10, bottom: 10, right: 20),
                          labelText: 'Enter Email-Id',
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
                        // controller: nameController,
                        obscureText: true,
                        onChanged: (value) {
                          pass = value;
                        },
                        style: const TextStyle(fontSize: 17),
                        decoration: InputDecoration(
                          //isDense: true,
                          contentPadding: const EdgeInsets.only(
                              left: 25, top: 10, bottom: 10, right: 20),
                          labelText: 'Enter Password',
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
                    load == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 40,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color(0xff27C1C1)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          //side: BorderSide(
                                          //color: Colors.black)
                                        ),
                                      ),
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                              const Size(50, 50))),
                                  onPressed: () async {
                                    setState(() {
                                      load = true;
                                    });
                                    await SignUp().signup(mail, pass, name);
                                   
                                    if (auth.currentUser != null) {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                            } else {
                                              setState(() {
                                                load = false;
                                              });
                                            }
                                  },
                                  child: Text(
                                    "Register",
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : const CircularProgressIndicator(),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 30,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xff27C1C1)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //side: BorderSide(
                                    //color: Colors.black)
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(50, 50))),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        load2 == false
                            ? SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                // color: Colors.red,
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(10)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 255, 255, 255)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ))),
                                  onPressed: () async {
                                    setState(() {
                                      load2 = true;
                                    });
                                    try{
                                      await GoogleLogin().signInWithGoogle();
                                      setState(() {
                                      load2 = false;
                                      });
                                    }catch(e){
                                      setState(() {
                                        load2 = false;
                                      });
                                      Fluttertoast.showToast(msg: "Error ${e.toString()}");
                                    }
                                    if (auth.currentUser != null) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Welcome ${auth.currentUser!.displayName}");
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()),
                                          (Route<dynamic> route) => false);
                                    }
                                  },
                                  icon: Image.asset(
                                    'assets/google.png',
                                    width: 35,
                                    height: 35,
                                  ),
                                  label: Text(
                                    "Login With Google",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ))
                            : const CircularProgressIndicator(),
                      ],
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ));
  }
}
