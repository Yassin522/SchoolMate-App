import 'package:get/get.dart';
import 'package:school_management_system/teacher/controllers/home_controller.dart';
import 'package:school_management_system/teacher/model/subject/TeacherSubjectModel.dart';
import 'package:school_management_system/teacher/resources/TsubjectsServices/TsubjectsServices.dart';

class TeacherSubjectController extends GetxController {
  var grade = ''.obs;
  var classId = ''.obs;
  var subjectServices = TSubjetcsServices();

  var teacherSubjectsList = [
    /* TeacherSubjectModel(
      subjectName: 'Math',
      subjectId: '',
    ),
    TeacherSubjectModel(
      subjectName: 'Art',
      subjectId: '',
    ),
    TeacherSubjectModel(
      subjectName: 'Music',
      subjectId: '',
    ),*/
  ].obs;

  getTeacherSubject() async {
    teacherSubjectsList.value = await subjectServices.getTeacherSubjectForClass(
        grade.value.toString(), classId.toString());
  }
}
