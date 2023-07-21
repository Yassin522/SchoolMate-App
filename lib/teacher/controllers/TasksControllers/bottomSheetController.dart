import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_management_system/student/models/Adjuncts/filtter/gradeCircle.dart';
import 'package:school_management_system/student/view/Adjuncts/Component/filtter/filtterComponent/subjectFiltter.dart';
import 'package:school_management_system/teacher/model/Home/classroomSectionModel.dart';
import 'package:school_management_system/teacher/model/Tasks/tasksModel.dart';
import 'package:school_management_system/teacher/view/tasks/AddFiles/components/Tgrade.dart';
import 'package:path/path.dart';
import 'package:school_management_system/teacher/view/tasks/TeacherTasksPage.dart';

import '../../resources/TaskServices/TaskServices.dart';

class BottomSheetController extends GetxController {
  var taskServices = TaskServices();
  var deadline = DateTime.now().obs;
  var file;
  var fileName = 'file name'.obs;
  var taskName = ''.obs;
  var teachersubject = [].obs;
  var selectedsubjecname = ''.obs;
  //gradeFilter
  var GradeNumber = [].obs;
  var currentGrade = 0.obs;
  updateGreadeIndex(int index) {
    currentGrade.value = index;
    update();
  }

  updateSubjectDropmenu(String newvalue) {
    selectedsubjecname.value = newvalue;
    update();
  }

  var classSection = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ].obs;
  var currentClassSection = 0.obs;
  updateClassSectionIndex(int? index) {
    currentClassSection.value = index!;
    update();
  }

  updateDeadline(DateTime newDate) {
    deadline.value = newDate;
    update();
  }

  updateFile(File newfile) {
    file = newfile == null ? file : newfile;
    fileName.value = basename(newfile.path);
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    GradeNumber.value = await taskServices.getTeachergardes();
    print('Grades is ');
    print(GradeNumber.value);
    teachersubject.value =
        await taskServices.getTeacherSubject(GradeNumber.value);
  }

  addTask() async {
    /*print(currentGrade.value.toString());
    print(GradeNumber.value[currentGrade.value - 1]);
    print(currentClassSection.value.toString());
    print(classSection.value[currentClassSection.value - 1].toString());
    print(deadline.value.toString());
    print(file.toString());
    print(fileName.value);
    print(taskName.value);
    print(selectedsubjecname.value.toString());*/
    var deadlineFormated = Timestamp.fromDate(deadline.value);
    var taskinfo = UploadTaskModel(
      name: taskName.value,
      classId: classSection.value[currentClassSection.value - 1].toString(),
      grade: GradeNumber.value[currentGrade.value - 1].toString(),
      file: file,
      deadLine: deadlineFormated,
      subjectName: selectedsubjecname.value.toString(),
    );
    await taskServices.addTask(taskinfo);
    taskcontroller.updateList();
  }
}
