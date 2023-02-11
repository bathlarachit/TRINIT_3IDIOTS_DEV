import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:trinit/Community/CommunityPost.dart';
import 'package:trinit/Modal/Staticfile.dart';

class CommunityPostCard extends StatefulWidget {
  CommunityPost post = CommunityPost("", "", "", "", [], []);

  CommunityPostCard(CommunityPost post) {
    this.post.commentKeys = post.commentKeys;
    this.post.createdBy = post.createdBy;
    this.post.mssg = post.mssg;
    this.post.photoLink = post.photoLink;
    this.post.postId = post.postId;
    // this.post.noOfLikes = post.noOfLikes;
    this.post.likes = post.likes;
  }

  @override
  State<CommunityPostCard> createState() => _CommunityPostCardState();
}

class _CommunityPostCardState extends State<CommunityPostCard> {
  // int noOfLikes = 0;
  bool liked = false;
  Color likeColor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // noOfLikes = widget.post.noOfLikes;
    print(Staticfile.uid.toString());
    liked = widget.post.likes.contains(Staticfile.uid.toString());
  }

  @override
  Widget build(BuildContext context) {
    return (Center(
      child: Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(84, 116, 253, 1),
              borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Container(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                height: 400.0,
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
                          widget.post.photoLink,
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
                            child: Text(widget.post.mssg,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    decoration: TextDecoration.none)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                                "Created By ${widget.post.createdBy.toString()}",
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    decoration: TextDecoration.none)),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(2.0),
                          //   child: Text(
                          //       "Likes Count : ${widget.post.noOfLikes.toString()}",
                          //       style: const TextStyle(
                          //           fontSize: 15.0,
                          //           color: Colors.white,
                          //           decoration: TextDecoration.none)),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  if (liked == false) {
                                    // noOfLikes++;
                                    liked = !liked;
                                    likeColor = Colors.pink;
                                  } else {
                                    // noOfLikes--;
                                    liked = !liked;
                                    likeColor = Colors.white;
                                  }
                                });
                              },
                              // style: ButtonStyle(
                              //     backgroundColor: MaterialStateProperty.all(
                              //         Colors.deepOrange)),
                              icon: Icon(Icons.favorite,
                                  color: likeColor, size: 20.0),
                              label: Text("Like"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    ));
  }
}
