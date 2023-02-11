// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trinit/Community/CommunityDetails.dart';

import '../BottomNavbar/BottomNavBar.dart';
import '../EnteringPage/Splash.dart';
import '../Modal/Staticfile.dart';

class CommunityLandingPage extends StatelessWidget {
  // CommunityLandingPage(Key? key) : super(key: key);
  final dbRef = FirebaseDatabase.instance.ref().child("Community");

   CommunityLandingPage({super.key});

  List<String> getKeys(DataSnapshot list) {
    print("adaada");
    print(list.key.toString());

    List<String> keysList = [];
    for (var element in list.children) {
      keysList.add(element.key.toString());
    }
    print(keysList.length);
    return keysList;
  }

  Future<List<CommunityDetails>> fetchCommunityDetails() async {
    final snapshot = await dbRef.get();
    if (snapshot.exists) {
      print("sas");
      List<CommunityDetails> communityList = [];
      for (var community in snapshot.children) {
        print("AAA");
        print(community.key.toString());
        print(community.child("domain").value.toString());
        print(community.child("motto").value.toString());
        print(community.child("photo").value.toString());
        // print(getKeys(community.child("memberList").value));
        try {
          CommunityDetails details = CommunityDetails(
              community.key.toString(),
              community.child("domain").value.toString(),
              getKeys(community.child("memberList")),
              community.child("motto").value.toString(),
              getKeys(community.child("ngoId")),
              community.child("photo").value.toString());
          communityList.add(details);
          print(communityList[0].memberList.length);
        } catch (e) {
          print(e);
        }
      }
      // print(communityList.toString());
      print("returned");
      return communityList;
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
                    image:
                        DecorationImage(image: AssetImage("assets/images/logo.png"))),
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
                    Staticfile.navIndex=0;
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
            return
             ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 50,
                      color: Colors.amber,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(snapshot.data![index].id),
                          Text(snapshot.data![index].domain),
                        ],
                      ));
                });
          }
        }
        return Container(
          height: 50,
          color: Colors.grey,
          child: const Text("Loading"),
        );
      }),
      future: fetchCommunityDetails(),
    )));
  }
}
