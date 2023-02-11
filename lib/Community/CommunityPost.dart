import 'dart:ffi';

class CommunityPost {
  String postId = "";
  String photoLink = "";
  String mssg = "";
  String createdBy = "";
  List<String> commentKeys = [];
  // int noOfLikes = 0;
  List<String> likes = [];

  CommunityPost(String postId, String photoLink, String mssg, String createdBy,
      List<String> commentKeys, List<String> likes) {
    this.postId = postId;
    this.photoLink = photoLink;
    this.mssg = mssg;
    this.createdBy = createdBy;
    this.commentKeys = commentKeys;
    // this.noOfLikes = noOfLikes;
    this.likes = likes;
  }
}
