// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:trinit/Community/CommunityDetailPage.dart';
import 'package:trinit/Community/CommunityDetails.dart';

import '../modal/Staticfile.dart';


class CommunityCard extends StatefulWidget {
  String id = "";
  String domain = "";
  List<String> memberList = [];
  String motto = "";
  List<String> ngoId = [];
  String photo = "";
  CommunityCard(CommunityDetails details, {super.key}) {
    id = details.id;
    domain = details.domain;
    memberList = details.memberList;
    motto = details.motto;
    ngoId = details.ngoId;
    photo = details.photo;
    print(ngoId.length);
  }

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  String userId = Staticfile.uid;
  final dbRef = FirebaseDatabase.instance.ref().child("Community");
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(userCheck().toString());
  }

  void addUserToMemberList(String communityId) async{
    if(Staticfile.type=="User")
    await dbRef.child(communityId.toString()).child("memberList").update({
      Staticfile.uid.toString():true,
    });
    else{
      await dbRef.child(communityId.toString()).child("ngoId").update({
      Staticfile.uid.toString():true,
    });
    }
  }

  bool userCheck() {
    if(Staticfile.type=="User"){
      return widget.memberList.contains(userId);
    }
    return widget.ngoId.contains(userId);
  }

  String getButtonString() {
    return (userCheck()) ? "Go to Community" : "Join Community";
  }

  @override
  Widget build(BuildContext context) {
    String btext=getButtonString();
    return Center(
      child: Container(
          decoration: BoxDecoration(
              color: const Color(0xFFd8f2fd),
              borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Container(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                height: 430.0,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 250.0,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xFFd8f2fd),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          widget.photo,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 150.0,
                      padding: const EdgeInsets.only(top: 8.0),
                      color: const Color(0xFFd8f2fd),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(widget.domain,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                    fontSize: 19.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    decoration: TextDecoration.none)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text("Motto : ${widget.motto}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    decoration: TextDecoration.none)),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                  "Members : ${widget.memberList.length.toString()}",
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      decoration: TextDecoration.none))),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                                "NGOs : ${widget.ngoId.length.toString()}",
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    decoration: TextDecoration.none)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: ElevatedButton(
                              onPressed: () {
                                
                                if (userCheck()) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CommunityDetailPage(
                                                  widget.domain)));
                                } else {
                                  addUserToMemberList(widget.id);
                                  setState(() {
                                    btext=getButtonString();        
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CommunityDetailPage(
                                                  widget.domain)));
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 255, 124, 124))),
                              child: Text(btext,
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      decoration: TextDecoration.none)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
