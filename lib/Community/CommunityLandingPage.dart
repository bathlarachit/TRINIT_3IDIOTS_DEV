import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:trinit/Community/CommunityDetails.dart';

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
    return FutureBuilder(
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
            return ListView.builder(
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
    );
  }
}
