import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:trinit/Community/CommunityDetails.dart';
import 'package:trinit/Community/CommunityDetailPage.dart';
import '../Modal/Staticfile.dart';


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
  }

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  late String userId = "";
  final dbRef = FirebaseDatabase.instance.ref().child("Community");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    userId = auth.currentUser == null ? "" : auth.currentUser!.uid;
    print(userCheck().toString());
  }

  void addUserToMemberList(String communityId) async{
    String userId = Staticfile.uid;
    await dbRef.child(communityId.toString()).child("memberList").update({
      userId.toString():true,
    });
  }

  bool userCheck() {
    // userId = "userid1";
    return widget.memberList.contains(userId);
  }

  String getButtonString() {
    return (userCheck()) ? "Go to Community" : "Join Community";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(84, 116, 253, 1),
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
                        color: const Color.fromRGBO(84, 116, 253, 1),
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
                      color: const Color.fromRGBO(84, 116, 253, 1),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(widget.domain,
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    decoration: TextDecoration.none)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(widget.motto,
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    decoration: TextDecoration.none)),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                  "${widget.memberList.length.toString()} members",
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      decoration: TextDecoration.none))),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                                "${widget.ngoId.length.toString()} NGOs associated",
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
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
                                }
                              ;
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepOrange)),
                              child: Text(getButtonString(),
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
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
