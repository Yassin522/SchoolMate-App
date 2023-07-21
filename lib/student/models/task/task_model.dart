import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/student/models/subjects/SubjectsModel.dart';
import 'package:school_management_system/teacher/model/Home/classRoomModel.dart';

class TaskModel {
  var id;
  var name;
  var classroom;
  var deadline;
  var subjectName;
  var teacher_id;
  var uploadDate;
  var url;

  TaskModel({
    this.id,
    this.name,
    this.classroom,
    this.deadline,
    this.subjectName,
    this.teacher_id,
    this.uploadDate,
    this.url,
  });

  static fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      name: json['name'],
      teacher_id: json['teacher_id'],
      classroom: json['classroom'],
      deadline: json['deadline'],
      subjectName: json['subjectName'],
      uploadDate: json['uploadDate'],
      url: json['url'],
    );
  }

  factory TaskModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TaskModel(
      id: data?['id'],
      name: data?['name'],
      classroom: data?['classroom'],
      teacher_id: data?['teacher_id'],
      deadline: data?['deadline'],
      subjectName: data?['subjectName'],
      uploadDate: data?['uploadDate'],
      url: data?['url'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (teacher_id != null) "teacher_id": teacher_id,
      if (classroom != null) "classroom": classroom,
      if (deadline != null) "deadline": deadline,
      if (subjectName != null) "subjectName": subjectName,
      if (uploadDate != null) "uploadDate": uploadDate,
      if (url != null) "url": url,
    };
  }
}
