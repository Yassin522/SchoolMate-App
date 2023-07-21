import 'dart:io';

import 'package:get/get.dart';
import 'package:school_management_system/teacher/model/TRefrenceModels/TAddvideoModel.dart';
import 'package:school_management_system/teacher/model/TRefrenceModels/TpdfAddFileModel.dart';
import 'package:school_management_system/teacher/resources/TAdjunctsServices/TAdjunctsServices.dart';
import 'package:path/path.dart';

import '../../Teacher_global_info/Subjects_of_teacher/TeacherSubjects.dart';

class TreferenceBottomsheetController extends GetxController {
  var refServices = TAdjunctsServices();

  var subjectList = [].obs;
  var selectedSuject = ''.obs;
  var gradeList = [].obs;
  var currentGrade = 0.obs;

  var pdf_name = ''.obs;
  var file;
  var fileName = 'Add file'.obs;

  updateUI(newValue) {
    selectedSuject.value = newValue;
    update();
  }

  updateGreadeIndex(int newIndex) {
    currentGrade.value = newIndex;
    update();
  }

  updateFile(File newfile) {
    file = newfile == null ? file : newfile;
    print(fileName.value.toString());
    fileName.value = basename(newfile.path);
    print(fileName.value.toString());
    update();
  }

  addPdf() async {
    print(selectedSuject.value);
    print(currentGrade.value);
    var index = subjectList.value
        .indexWhere((element) => element.subjectName == selectedSuject.value);
    print(subjectList[index].subjectId);
    print(file);
    print(fileName.value);
    print(pdf_name.value);
    await refServices.addFile(TpdfAddFileModel(
      grade: int.parse(gradeList.value[currentGrade.value]),
      name: pdf_name.value,
      subjectName: selectedSuject.value,
      subject_id: subjectList[index].subjectId,
      type: 'book',
      file: file,
    ));
    update();
  }

  ////////////////Video/////////
  var video_name = ''.obs;
  var video_url = ''.obs;

  addVideo() async {
    print(selectedSuject.value);
    print(currentGrade.value);
    var index = subjectList.value
        .indexWhere((element) => element.subjectName == selectedSuject.value);
    print(subjectList[index].subjectId);
    print(video_name.value);
    print(video_url.value);

    await refServices.addVideo(AddVideoModel(
      grade: int.parse(gradeList.value[currentGrade.value]),
      name: video_name.value,
      subjectName: selectedSuject.value,
      subject_id: subjectList[index].subjectId,
      type: 'video',
      url: video_url.value,
    ));

    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    print(TeacherSubjects.subjectsList);
    subjectList.value = TeacherSubjects.subjectsList;
    selectedSuject.value = subjectList.value[0].subjectName;
    gradeList.value = await refServices.getAllGrade();
  }
}
