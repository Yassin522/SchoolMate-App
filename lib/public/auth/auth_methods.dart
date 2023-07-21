import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../config/user_information.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googlSignIn = GoogleSignIn();
  GetStorage storage = GetStorage();
  var uid;

  Future<String> loginStudent({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        String currentuser = _auth.currentUser!.uid;
        UserInformation.User_uId = currentuser;
        await storage.write('uid', UserInformation.User_uId);
        res = "success";
        print("eeeeeeeeeeeeeeee");
        print(UserInformation.User_uId);
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
