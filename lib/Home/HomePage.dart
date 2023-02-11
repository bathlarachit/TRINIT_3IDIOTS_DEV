// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trinit/BottomNavbar/BottomNavBar.dart';
import 'package:trinit/constants.dart';
import '../EnteringPage/Splash.dart';
import '../components/bigCard.dart';

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
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"))),
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
        bottomNavigationBar: BottomNavbar().navbar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Image(
                      height: 70,
                      width: 70,
                      image: AssetImage('assets/images/man.png'),
                    ),
                    Column(
                      children: const [
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Sunday, 12 Febraury'),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended for You',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    TextButton(onPressed: () {}, child: Text('View More'))
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) => BigCard(),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Explore the NGO', style: tstyle),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/NgoList');
                        },
                        child: Text('View more'))
                  ],
                ),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) => BigCard(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
