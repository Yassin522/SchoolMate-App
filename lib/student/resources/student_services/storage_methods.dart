

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:school_management_system/public/config/user_information.dart';

class StorageMethods{

   final FirebaseStorage _storage=FirebaseStorage.instance;
   final FirebaseAuth _auth =FirebaseAuth.instance;


   Future<String> uploadImageToStorage(String childName, Uint8List file) async{
       Reference ref=_storage.ref().child(childName).child(_auth.currentUser!.uid);
       UploadTask uploadTask=ref.putData(file);
       TaskSnapshot snap=await uploadTask;
       String downloadUrl=await snap.ref.getDownloadURL();
       print(downloadUrl);
       return downloadUrl;

   }
}