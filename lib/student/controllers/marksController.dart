import 'package:get/state_manager.dart';
import 'package:school_management_system/student/models/Subjects/SubjectsModel.dart';
import 'package:school_management_system/student/resources/subject/marksServices.dart';

class MarksController extends GetxController {
  var marksServices = MarkServices();
  var marksList = [
    /*MarksModel(title: 'Exam1', mark: 15, fmark: 30),
    MarksModel(title: 'Quizz1', mark: 14, fmark: 20),
    MarksModel(title: 'HomeWorks', mark: 20, fmark: 20),
    MarksModel(title: 'Exam2', mark: 25, fmark: 30),*/
  ].obs;

  var exam1 = MarksModel().obs;
  var tests = MarksModel().obs;
  var homeworks = MarksModel().obs;
  var exam2 = MarksModel().obs;
  var subjectId = ''.obs;
  getExam1(String subjectId) async {
    exam1.value = await marksServices.getExam1Result(subjectId);
  }

  getTests(String subjectId) async {
    tests.value = await marksServices.getTestsResult(subjectId);
  }

  getHomeworks(String subjectId) async {
    homeworks.value = await marksServices.getHomeworksResult(subjectId);
  }

  getExam2(String subjectId) async {
    exam2.value = await marksServices.getExam2Result(subjectId);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    print(subjectId.value);
    super.onReady();
  }
}
