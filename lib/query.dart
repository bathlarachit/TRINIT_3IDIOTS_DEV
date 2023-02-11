import 'modal/ngo.dart';

List<String> getKeyWords(String str) {
  List<String> klist = [];
  str = str.toLowerCase();
  klist = str.split(',');

  return klist;
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
