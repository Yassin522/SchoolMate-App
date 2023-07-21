import 'package:get/state_manager.dart';
import 'package:school_management_system/teacher/resources/TsubjectsServices/TlessonsServices.dart';

class SubjectMainScreenController extends GetxController {
  var lessonServices = TLessonsServices();

  var lessonNumber = 0.obs;
  var takenLessonNumber = 0.obs;
  var subjectId = ''.obs;

  getlessonsNumer() async {
    lessonNumber.value =
        await lessonServices.getLessonsNumber(subjectId.value.toString());
  }

  getTakenlessonsNumer() async {
    takenLessonNumber.value =
        await lessonServices.getTakenLessonsNumber(subjectId.value.toString());
  }
}
