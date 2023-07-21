import 'package:school_management_system/student/models/chat/student.dart';

class TaskMarkModel {
  final taskid;
  final classRoom_id;
  final student_id;
  late final StudenUploadDate;
  final urlFromFireStorge;
  late final mark;
  late final st_uploadDate;
  TaskMarkModel({
    this.taskid,
    this.StudenUploadDate,
    this.mark,
    this.student_id,
    this.classRoom_id,
    this.urlFromFireStorge,
  });
}
