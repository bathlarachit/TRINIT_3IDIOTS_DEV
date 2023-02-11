import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trinit/Community/CommunityPost.dart';
import 'package:trinit/Community/CommunityPostCard.dart';

import '../BottomNavbar/BottomNavBar.dart';
import '../EnteringPage/Splash.dart';
import '../Modal/Staticfile.dart';

class CommunityDetailPage extends StatefulWidget {
  String domain = "";

  CommunityDetailPage(String domain) {
    print(domain);
    this.domain = domain;
  }

  @override
  State<CommunityDetailPage> createState() => _CommunityDetailPageState();
}

class _CommunityDetailPageState extends State<CommunityDetailPage> {
  final dbRef = FirebaseDatabase.instance.ref().child("CommunityPosts");

  List<String> getKeys(DataSnapshot list) {
    List<String> listKeys = [];
    for (var child in list.children) {
      listKeys.add(child.key.toString());
    }
    return listKeys;
  }

  Future<List<CommunityPost>> fetchCommunityPosts() async {
    final snapshot = await dbRef.child(widget.domain.toString()).get();
    if (snapshot.exists) {
      List<CommunityPost> communityPosts = [];
      for (var post in snapshot.children) {
        CommunityPost postDetail = CommunityPost(
            post.key.toString(),
            post.child("photoLink").value.toString(),
            post.child("mssg").value.toString(),
            post.child("createdBy").value.toString(),
            getKeys(post.child("comments")),
            post.child("noOfLikes").value as int,
            getKeys(post.child("likes")));
        print(postDetail.createdBy);
        print(postDetail.mssg);
        print(postDetail.noOfLikes);
        communityPosts.add(postDetail);
      }
      return communityPosts;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
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
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(10)),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 255, 255, 255)),
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
            body: FutureBuilder(
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // show Error
                    return Container(
                      height: 50,
                      color: Colors.red[300],
                      child: const Text("Error vhvh"),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CommunityPostCard(snapshot.data![index]);
                          });
                    }
                  }
                }
                return Container(
                  height: 50,
                  color: Colors.grey,
                  child: const Text("Loading"),
                );
              }),
              future: fetchCommunityPosts(),
            )));
  }
}
