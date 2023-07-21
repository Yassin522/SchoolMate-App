import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/teacher/view/tasks/AddFiles/components/SelectFile.dart';

class TProfileServices {
  updateImage(file) async {
    try {
      var dest =
          '/profilePics/teachers/${UserInformation.first_name} ${UserInformation.last_name}';
      var url = await uploadImageToStorage(dest.toString(), file);
      print('*************');
      print(url);
      await FirebaseFirestore.instance
          .collection('teacher')
          .doc(UserInformation.User_uId)
          .update(
        {
          'urlAvatar': url,
        },
      );
      return url;
    } catch (e) {
      print('@#@#@#@#@#@#@#@#@#@#');
      print(e);
      return null;
    }
  }
}
