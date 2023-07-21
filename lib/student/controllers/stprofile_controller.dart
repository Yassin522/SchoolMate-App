import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/student/resources/student_services/stservices.dart';

import '../../teacher/resources/ProfilesServices/SProfileservices.dart';
import '../resources/stProfileServices/stProfileServices.dart';
import '../resources/student_services/storage_methods.dart';

class StprofileController extends GetxController {
  Rx<Uint8List> image = Uint8List(0).obs;
  var ok = true.obs;
  var ok2 = false.obs;

  RxString photoUrl = "GG".obs;
  List info = [].obs;
  RxString firstname = "".obs;
  RxString fullname = "".obs;
  RxInt grade = 0.obs;
  RxInt Class = 0.obs;
  RxInt phone = 0.obs;
  RxInt parentphone = 0.obs;
  RxInt fees = 0.obs;
  RxDouble grade_average = 0.1.obs;
  var studentMarks = [].obs;
  var isShow = false.obs;

  @override
  void onInit() async {
    //getstudentdata(UserInformation.User_uId);
    super.onInit();
  }

  getStudentMark() async {
    var proServices = StdProfileServices();
    studentMarks.value = await proServices.getStudentMarks(
        UserInformation.grade.toString(),
        UserInformation.classid.toString(),
        UserInformation.User_uId.toString());
  }

  showDetails() {
    isShow.value = !isShow.value;
    update();
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    }
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    UserInformation.urlAvatr =
        await StorageMethods().uploadImageToStorage('profilePics', im);
    final data1 = <String, dynamic>{
      "urlAvatar": UserInformation.urlAvatr,
    };
    await FirebaseFirestore.instance
        .collection('students')
        .doc(UserInformation.User_uId)
        .set(data1, SetOptions(merge: true));
    image.value = im;
    ok.value = false;
    update();
  }

  showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  getstudentdata(String studentid) async {
    print("sssssssssssssssss");
    info = await StudentApi.getinfo(studentid);
    print(info[0].Class);
    firstname.value = info[0].first_name;
    fullname.value = firstname + " " + info[0].last_name;
    grade.value = info[0].grade;
    Class.value = info[0].Class;
    parentphone.value = info[0].parentphone;
    phone.value = info[0].phone;
    fees.value = info[0].fees;
    grade_average.value = info[0].grade_average;
    photoUrl.value = info[0].urlAvatar;
    ok2.value = true;
    update();
  }
}
