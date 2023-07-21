import 'package:get/state_manager.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/teacher/model/ProfileModels/TProfileInfoModel.dart';

import '../../Teacher_global_info/Subjects_of_teacher/TeacherSubjects.dart';
import '../../resources/ProfilesServices/TprofileServices.dart';

class TProfileController extends GetxController {
  var PrServices = TProfileServices();
  var teacherInfo = TProfileInfoModel(
          /* fname: 'Georno',
    lname: 'Geovana',
    subjects: [
      'Math',
      'Art',
      'Art',
      'Art',
    ],
    about: 'My Name is Georno Geovana and i have dream!!',
    email: 'modamode@gmail.com',*/
          )
      .obs;

  updateImage(img) async {
    teacherInfo.value.photoUrl = await PrServices.updateImage(img);
    print(teacherInfo.value.photoUrl);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    teacherInfo.value.fname = UserInformation.first_name;
    teacherInfo.value.lname = UserInformation.last_name;
    teacherInfo.value.about = UserInformation.about;
    teacherInfo.value.email = UserInformation.email;
    teacherInfo.value.subjects = TeacherSubjects.subjectsList;
  }
}
