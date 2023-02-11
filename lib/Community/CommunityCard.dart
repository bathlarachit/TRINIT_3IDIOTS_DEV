import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trinit/Community/CommunityDetails.dart';

class CommunityCard extends StatefulWidget {
  String id = "";
  String domain = "";
  List<String> memberList = [];
  String motto = "";
  List<String> ngoId = [];
  String photo = "";
  CommunityCard(CommunityDetails details) {
    this.id = details.id;
    this.domain = details.domain;
    this.memberList = details.memberList;
    this.motto = details.motto;
    this.ngoId = details.ngoId;
    this.photo = details.photo;
  }

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  late String userId = "userid1";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    userId = auth.currentUser == null ? "" : auth.currentUser!.uid;
    print(userCheck().toString());
  }

  bool userCheck() {
    userId = "userid1";
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
                              onPressed: () {print("hello")},
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
