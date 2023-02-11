class CommunityDetails {
  String id = "";
  String domain = "";
  List<String> memberList = [];
  String motto = "";
  List<String> ngoId = [];
  String photo = "";

  CommunityDetails(String id,String domain,List<String> memberList,String motto,List<String> ngoId,String photo) {
    this.id = id;
    this.domain = domain;
    this.memberList = memberList;
    this.motto = motto;
    this.ngoId = ngoId;
    this.photo = photo;
  }
}
