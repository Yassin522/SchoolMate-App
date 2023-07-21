class TMarksStudentModel {
  final url;
  final name;
  final mark;
  final stdid;
  TMarksStudentModel({this.mark, this.name, this.url, this.stdid});
}

class StundentMarksModel {
  var fname;
  var lname;
  var photoUrl;
  var id;
  StundentMarksModel({this.fname, this.id, this.lname, this.photoUrl});
}

class StudentMarkInprofile {
  var subjectname;
  var test;
  var homework;
  var exam1;
  var exam2;

  StudentMarkInprofile(
      {this.exam1, this.exam2, this.homework, this.subjectname, this.test});
}

class DropmenueModel {
  var subjectName;
  var subjectId;
  DropmenueModel({this.subjectId, this.subjectName});
}

class AddingMarkModel {
  var mark;
  var subject;
  var fmark;
  var grade;
  var uid;
  var type;
  AddingMarkModel(
      {this.mark, this.fmark, this.grade, this.subject, this.type, this.uid});
}
