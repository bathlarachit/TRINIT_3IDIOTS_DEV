import 'package:firebase_database/firebase_database.dart';

import '../modal/ngo.dart';

Future<List<NGO>> getNgoList() async {
  List<NGO> ngoList = [];
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('Ngo').get();
  if (snapshot.exists) {
    for (var i in snapshot.children) {
      try {
        NGO ngo = NGO(
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
          impact: [],
          // for(var j in i.child('impact').childer)
          // {

          // }
          mission: i.child('mission').value.toString(),
          photo_link: i.child('photo').value.toString(),
          prev_work: i.child('previousWork').value,
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
