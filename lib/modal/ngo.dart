// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

class NGO {
  String name;
  var impact = [];
  var community = [];
  var acc_num;
  var ifsc;
  String key = "",mail="";
  String loc;
  String acc_name;
  var mission;
  var photo_link;
  var prev_work;

  var UpiId;
  NGO({
    required this.name,
    required this.impact,
    required this.community,
    required this.acc_num,
    required this.ifsc,
    required this.key,
    required this.loc,
    required this.UpiId,
    required this.acc_name,
    required this.mission,
    required this.photo_link,
    required this.prev_work,
    required this.mail,

  });
}

class Funds {
  String FundRaised;
  String fundUsed;
  String trans;
  Funds({
    required this.FundRaised,
    required this.fundUsed,
    required this.trans,
  });
}
