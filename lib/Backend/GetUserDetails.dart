import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:trinit/Modal/Staticfile.dart';

class GetUserDetails {
  void getUserDetails(String status) async{
    Staticfile().reset();
    FirebaseDatabase db = FirebaseDatabase.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    String path = (status=="NGO"?"/Ngo/":"Users")+auth.currentUser!.uid;
    DataSnapshot s = await db.ref(path).get();
    Staticfile.uid=s.key.toString();
    Staticfile.name=s.child("name").value.toString();
    Staticfile.email=s.child("email").value.toString();
    Staticfile.phn=s.child("phone").value.toString();
    Staticfile.photo=s.child("photo").value.toString();
    Staticfile.type=status=="NGO"?"Ngo":"User";
    Staticfile.mission=status=="NGO"?s.child("mission").value.toString():"";
  }
  
}