// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trinit/BottomNavbar/BottomNavBar.dart';
import 'package:trinit/Modal/Staticfile.dart';
import 'package:trinit/constants.dart';
import 'package:trinit/query.dart';
import 'package:trinit/searchResult.dart';
import '../EnteringPage/Splash.dart';
import '../Ngo/ngo_fetch.dart';
import '../components/bigCard.dart';
import '../components/info.dart';
import '../modal/ngo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  var query = "";
  List<NGO> ngoList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 Image(
                      height: 70,
                      width: 70,
                      image: AssetImage('assets/images/man.png'),
                    ),
                    Column(
                      children: [
                        Text(
                          "Welcome Back!${Staticfile.name}",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black)),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Sunday, 12 Febraury',style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),),
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
                
                SizedBox(height: 20),
                Row(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        query = value;
                      },
                      decoration: const InputDecoration(
                          constraints: BoxConstraints(maxWidth: 280),
                          focusedBorder: OutlineInputBorder(),
                          hintText: "Search for NGO's....",
                          border: InputBorder.none),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await getNgoList().then((value) {
                          setState(() {
                            ngoList = value;
                          });
                          var qlist = filter(getKeyWords(query), ngoList);
                          // print('qlist');
                          // print(qlist.length);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchResult(
                                        ngo: qlist,
                                      )));
                        });
                      },
                      child: Container(
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
                // SizedBox(
                //   height: 250,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 5,
                //     itemBuilder: (BuildContext context, int index) => BigCard(
                //                 img: snapshot.data![index].photo_link,
                //                 name: snapshot.data![index].name),,
                //   ),
                // ),
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
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Loading'));
                      }

                      // WHEN THE CALL IS DONE BUT HAPPENS TO HAVE AN ERROR
                      if (snapshot.hasError) {
                        return const Center(child: Text('Error'));
                      }

                      // IF IT WORKS IT GOES HERE!
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoPage(
                                            ngo: snapshot.data![index],
                                          )));
                            },
                            child: BigCard(
                                img: snapshot.data![index].photo_link,
                                name: snapshot.data![index].name),
                          );
                        },
                      );
                    },
                    future: getNgoList(),
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
