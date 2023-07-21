import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class taskStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late File file;
  var task = ImagePicker();
 

  Future<String> uploadTask() async {
    var fileicked = await task.getImage(source: ImageSource.gallery);
    if (fileicked != null) {
      file = File(fileicked.path);
      var imageName = basename(fileicked.path);
      print(imageName);
//load
      var refStorage =
          _storage.ref("task/$imageName").child(_auth.currentUser!.uid);
      await refStorage.putFile(file);
      String Url = await refStorage.getDownloadURL();
      print("Url=============: $Url");
      return Url;
    } else {
      var error = "NOOOOOOOOOOOOOOO";
      return error;
    }
  }
}
