// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trinit/Modal/Users.dart';

import '../../Backend/SignUp.dart';
import '../Password/OtpF.dart';
import 'Login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Users user = Users();
  bool load = false, load2 = false;
  int selectedRadio = 0;

  setSelectedRadio(val) {
    setState(() {
      selectedRadio = val;
    });
  }
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        RadioListTile(
                            dense: true,
                            value: 0,
                            title: const Text("Philanthropists"),
                            groupValue: selectedRadio,
                            onChanged: (val) {
                              setSelectedRadio(val);
                            }),
                        RadioListTile(
                            dense: true,
                            value: 1,
                            title: const Text("NGO"),
                            groupValue: selectedRadio,
                            onChanged: (val) {
                              setSelectedRadio(val);
                            }),
                        
                      ]),
                  Column(children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: TextField(
                        // controller: nameController,
                        onChanged: (value) {
                          user.name = value;
                        },
                        style: const TextStyle(fontSize: 17),
                        decoration: InputDecoration(
                          //isDense: true,
                          contentPadding: const EdgeInsets.only(
                              left: 25, top: 10, bottom: 10, right: 20),
                          labelText: selectedRadio==0?'Enter Name':'Enter NGO Name',
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
                          user.email = value;
                        },
                        style: const TextStyle(fontSize: 17),
                        decoration: InputDecoration(
                          //isDense: true,
                          contentPadding: const EdgeInsets.only(
                              left: 25, top: 10, bottom: 10, right: 20),
                          labelText: selectedRadio==0?'Enter Email-Id':'Enter NGO Email-Id',
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
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          user.phn = value;
                          //print(phn);
                        },
                        style: const TextStyle(fontSize: 17),
                        decoration: InputDecoration(
                          //isDense: true,
                          contentPadding: const EdgeInsets.only(
                              left: 25, top: 10, bottom: 10, right: 20),
                          labelText: selectedRadio==0?'Enter Phone Number':'Enter NGO Phone Number',
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
                          user.pass = value;
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
                                    int x = await SignUp().signup(user);
                                   
                                    if (x==1) {
                                      user.status=selectedRadio==0?"User":"NGO";
                                      user.phn="+91${user.phn}";
                                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>OtpScreen(user)),
                                          );
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
                    const SizedBox(height: 15,),
                    const SizedBox(
                      child: Text("OR"),
                    ),
                    const SizedBox(height: 15,),
                    Row(
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
