import 'package:get/state_manager.dart';
import 'package:school_management_system/student/models/Subjects/SubjectsModel.dart';
import 'package:school_management_system/student/resources/subject/lessonsServices.dart';
import 'package:school_management_system/student/view/Subjects/LessonsScreen.dart';

class lessonsController extends GetxController {
  var lessonsServices = LessonsServices();
  RxList lessonslist = <lessonModel>[
    lessonModel(title: 'equation', checked: false),
    /*lessonModel(title: 'Squres and tringles', checked: false),
    lessonModel(title: 'Power of varibles ', checked: false),
    lessonModel(title: 'Examples', checked: false),*/
  ].obs;

  var subjectId = ''.obs;
  var numberOftakenLessons = 0.obs;
  var numberOfAllLessons = 0.obs;
  updateCheckBox(int index) {
    if (lessonslist.value[index - 1].checked == true)
      --numberOftakenLessons.value;
    else
      ++numberOftakenLessons.value;
    lessonslist.value[index - 1].checked =
        !lessonslist.value[index - 1].checked;

    update();
  }

  getSubjectId(String id) {
    subjectId.value = id.toString();
  }

  getTakenLessonNumber(String id) async {
    numberOftakenLessons.value = await lessonsServices.getTakenLessonNumbe(id);
    return numberOftakenLessons;
  }

  getAllLessonNumber(String id) async {
    return numberOfAllLessons.value =
        await lessonsServices.getAllLessonNumbe(id);
  }

  getLessons(String id) async {
    lessonslist.value = await lessonsServices.getlessons(id);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('subject id is :' + subjectId.value);
  }

  //Marks

}
