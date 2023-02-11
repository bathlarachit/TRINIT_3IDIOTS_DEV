import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:trinit/Community/CommunityCard.dart';
import 'package:trinit/Community/CommunityDetails.dart';

class CommunityLandingPage extends StatelessWidget {
  // CommunityLandingPage(Key? key) : super(key: key);
  final dbRef = FirebaseDatabase.instance.ref().child("Community");

  List<String> getKeys(DataSnapshot list) {
    List<String> keysList = [];
    for (var child in list.children) {
      keysList.add(child.key.toString());
    }
    return keysList;
  }

  Future<List<CommunityDetails>> fetchCommunityDetails() async {
    final snapshot = await dbRef.get();
    if (snapshot.exists) {
      print("sas");
      List<CommunityDetails> communityList = [];
      for (var community in snapshot.children) {
        CommunityDetails details = CommunityDetails(
            community.key.toString(),
            community.child("domain").value.toString(),
            getKeys(community.child("memberList")),
            community.child("motto").value.toString(),
            getKeys(community.child("ngoId")),
            community.child("photo").value.toString());
        communityList.add(details);
      }
      return communityList;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // show Error
            return Container(
              height: 50,
              color: Colors.red[300],
              child: Text("Error vhvh"),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CommunityCard(snapshot.data![index]);
                  });
            }
          }
        }
        return Container(
          height: 50,
          color: Colors.grey,
          child: Text("Loading"),
        );
      }),
      future: fetchCommunityDetails(),
    );
  }
}
