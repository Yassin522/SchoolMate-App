class TeacherTasksModel {
  var taskName;
  var taskSubjectName;
  var taskClassroomId;
  var uploadDate;
  var deadLine;
  var taskId;
  var subjectId;
  var url;

  TeacherTasksModel({
    this.taskClassroomId,
    this.taskName,
    this.taskId,
    this.taskSubjectName,
    this.deadLine,
    this.uploadDate,
    this.subjectId,
    this.url,
  });
}

class UploadTaskModel {
  var name;
  var deadLine;
  var subjectName;
  var uploadDate;
  var file;
  var classId;
  var teacherId;
  var grade;
  UploadTaskModel({
    this.classId,
    this.deadLine,
    this.name,
    this.subjectName,
    this.teacherId,
    this.uploadDate,
    this.file,
    this.grade,
  });
}
