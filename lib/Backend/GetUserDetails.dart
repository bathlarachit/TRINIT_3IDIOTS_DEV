// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:trinit/modal/Staticfile.dart';

class GetUserDetails {
  Future getUserDetails(String status) async{
    Staticfile().reset();
    FirebaseDatabase db = FirebaseDatabase.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    String path = (status=="NGO"?"/Ngo/":"Users/")+auth.currentUser!.uid;
    DataSnapshot s = await db.ref(path).get();
    Staticfile.uid=s.key.toString();
    Staticfile.name=s.child("name").value.toString();
    Staticfile.email=s.child("mail").value.toString();
    Staticfile.phn=s.child("phone").value.toString();
    Staticfile.mission=s.child("mission").value.toString();
    Staticfile.accName=s.child("accountProof/accountName").value.toString();
    Staticfile.accNo=s.child("accountProof/accountNo").value.toString();
    Staticfile.ifsc=s.child("accountProof/ifsc").value.toString();
    Staticfile.upiId=s.child("accountProof/upiId").value.toString();
    Staticfile.photo=s.child("photo").value.toString();
    Staticfile.location=s.child("location").value.toString();
    Staticfile.type=status=="NGO"?"Ngo":"User";
    Staticfile.mission=status=="NGO"?s.child("mission").value.toString():"";
    for(var z in s.child(status=="NGO"?"impact":"interests").children){
      Staticfile.selectedImpact.add(z.key.toString());
    }
    print("djfdfj"+Staticfile.email.toString());
  }
  
}