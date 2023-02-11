import 'modal/ngo.dart';

List<String> getKeyWords(String str) {
  List<String> klist = [];
  str = str.toLowerCase();
  klist = str.split(',');

  return klist;
}

List<NGO> recFilter(List<NGO> nglist, List<String> sList) {
  List<NGO> ngv = [];

  for (int i = 0; i < nglist.length; i++) {
    var t = 0;
    for (var j in sList) {
      for (var k in nglist[i].impact) {
        if (j == k) {
          t = 1;
          break;
        }
      }
    }
    ngv.add(nglist[i]);
  }

  return ngv;
}

List<NGO> filter(klist, List<NGO> nglist) {
  List<NGO> nlist = [];

  for (int i = 0; i < nglist.length; i++) {
    for (var j in klist) {
      if (j == nglist[i].loc.toLowerCase() ||
          j == nglist[i].name.toLowerCase()) {
        nlist.add(nglist[i]);
        break;
      }
    }
  }

  // print('Lenght');
  // print(nlist.length);

  return nlist;
}
