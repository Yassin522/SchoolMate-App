import 'package:cloud_firestore/cloud_firestore.dart';

class Subject {
  var name;
  var description;
  Subject({this.name, this.description});
}

class lessonModel {
  var checked;
  var title;
  var id;
  var subjectid;

  lessonModel({
    this.title,
    this.checked,
    this.id,
    this.subjectid,
  });
}

class MarksModel {
  var title;
  var mark;
  var fmark;

  MarksModel({
    this.title,
    this.mark,
    this.fmark,
  });
}
