// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trinit/Modal/Users.dart';

class SignUp {
  FirebaseDatabase db = FirebaseDatabase.instance;

  Future signup(Users user) async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(user.email);
    bool ph = RegExp("^([0-9]{10})").hasMatch(user.phn);
    if (emailValid == false) {
      //Fluttertoast.showToast(msg: user.mail);
      Fluttertoast.showToast(msg: "Email address not valid");
      return 0;
    }
    if (ph==false){
      Fluttertoast.showToast(msg: "Phone Number not valid");
      return 0;
    }
    if (user.name == "") {
      Fluttertoast.showToast(msg: "User Name cannot be empty!!!");
      return 0;
    }
    if (user.pass.length <= 5) {
      Fluttertoast.showToast(msg: "Password length cannot be less than 5!!");
      return 0;
    }
    return 1;
    // }
    // FirebaseAuth auth = FirebaseAuth.instance;
    // try {
    //   await auth.createUserWithEmailAndPassword(email: user.email, password: user.pass);
    //   auth.currentUser!.updateDisplayName(user.name);
    //   Fluttertoast.showToast(msg: "Registered Successfully");
    // } catch (error) {
    //   Fluttertoast.showToast(msg: "FireBase Error:-$error");
    // }
  }
}
