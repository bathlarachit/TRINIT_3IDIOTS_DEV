import 'package:firebase_database/firebase_database.dart';

import '../modal/ngo.dart';

Future<Funds> getFunds(String key) async {
  Funds x;
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('Ngo').get();
  if (snapshot.exists) {
    var snap;
    try {
      var fundR = snapshot.child(key).child('fundRaised').value.toString();
      var fundU = snapshot.child(key).child('fundUsed').value.toString();
      var fundT = snapshot.child(key).child('fundTrans').value.toString();

      x = Funds(FundRaised: fundR, fundUsed: fundU, trans: fundT);
      return x;
    } catch (e) {
      return Funds(FundRaised: "", fundUsed: "", trans: "");
    }
  }
  return Funds(FundRaised: "", fundUsed: "", trans: "");
}

Future<List<NGO>> getNgoList() async {
  List<NGO> ngoList = [];
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('Ngo').get();
  if (snapshot.exists) {
    for (var i in snapshot.children) {
      try {
        var imp = [];
        var trans = [];
        for (var j in i.child('impact').children) {
          imp.add(j);
        }

        NGO ngo = NGO(
          UpiId: i.child("accountProof").child('upiId').value.toString(),
          key: i.key.toString(),
          loc: i.child("location").value.toString(),
          name: i.child("name").value.toString(),
          acc_name:
              i.child("accountProof").child('accountName').value.toString(),
          ifsc: i.child("accountProof").child('ifsc').value.toString(),
          acc_num: i.child("accountProof").child('accountNo').value.toString(),
          community: [],
          impact: imp,
          mission: i.child('mission').value.toString(),
          photo_link: i.child('photo').value.toString(),
          prev_work: i.child('previousWork').value,
          mail: i.child('email').value.toString(),
        );

        ngoList.add(ngo);
      } catch (e) {
        print(e);
      }
    }

    return ngoList;
  } else {
    return [];
  }
}

Future<List<NGO>> getNgoListWithFilter(List<String> nlist) async {
  List<NGO> ngoList = [];
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('Ngo').get();
  if (snapshot.exists) {
    for (var i in snapshot.children) {
      try {
        var imp = [];

        int flag = 1;
        for (var j in i.child('impact').children) {
          imp.add(j.key);
          for (var z in nlist) {
            if (z == j.key) {
              flag = 0;
              print("Equall");
            }
          }
        }
        if (flag == 0) continue;
        NGO ngo = NGO(
          UpiId: i.child("accountProof").child('upiId').value.toString(),
          key: i.key.toString(),
          loc: i.child("location").value.toString(),
          name: i.child("name").value.toString(),
          acc_name:
              i.child("accountProof").child('accountName').value.toString(),
          ifsc:
              int.parse(i.child("accountProof").child('ifsc').value.toString()),
          acc_num: int.parse(
              i.child("accountProof").child('accountNo').value.toString()),
          community: [],
          impact: imp,
          mission: i.child('mission').value.toString(),
          photo_link: i.child('photo').value.toString(),
          prev_work: i.child('previousWork').value,
          mail: i.child('email').value.toString(),
        );

        ngoList.add(ngo);
      } catch (e) {
        print(e);
      }
    }

    return ngoList;
  } else {
    return [];
  }
}
