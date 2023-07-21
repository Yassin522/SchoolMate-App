import 'package:school_management_system/student/models/Subjects/SubjectsModel.dart';

class TeacherSubjectModel {
  final subjectName;
  final subjectId;
  final lessons;
  final grade;
  TeacherSubjectModel(
      {this.subjectId, this.subjectName, this.grade, this.lessons});
}
