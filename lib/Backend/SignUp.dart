// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp {
  FirebaseDatabase db = FirebaseDatabase.instance;

  Future signup(String mail, String pass, String name) async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(mail);
    if (emailValid == false) {
      //Fluttertoast.showToast(msg: user.mail);
      Fluttertoast.showToast(msg: "Email address not valid");
      return;
    }
    if (name == "") {
      Fluttertoast.showToast(msg: "User Name cannot be empty!!!");
      return;
    }
    if (pass.length <= 5) {
      Fluttertoast.showToast(msg: "Password length cannot be less than 5!!");
      return;
    }
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(email: mail, password: pass);
      auth.currentUser!.updateDisplayName(name);
      Fluttertoast.showToast(msg: "Registered Successfully");
    } catch (error) {
      Fluttertoast.showToast(msg: "FireBase Error:-$error");
    }
  }
}
