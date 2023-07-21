import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/student/models/Adjuncts/filtter/DifficultyFiltter.dart';
import 'package:school_management_system/student/models/Adjuncts/filtter/filteredData.dart';
import 'package:school_management_system/student/models/Adjuncts/filtter/gradeCircle.dart';
import 'package:school_management_system/student/models/Adjuncts/filtter/subjectFiltterModel.dart';
import 'package:school_management_system/student/models/Adjuncts/refrencesFiles.dart';
import 'package:school_management_system/student/models/Adjuncts/refrencesVideos.dart';
import 'package:school_management_system/student/resources/RefrencesServices/RefrencesPdfServices.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

import '../../teacher/resources/TAdjunctsServices/TAdjunctsServices.dart';

class RefrencesController extends GetxController {
  //Books refrences
  var filesinfo = [].obs;
  RefrencesPdfServices references = RefrencesPdfServices();
  @override
  void onInit() async {
    super.onInit();
    for (var item in UserInformation.Subjects) {
      subjectsName.value.add(SubjectFiltter(subjectName: item.name));
    }
    var serv = TAdjunctsServices();
    var grades = await serv.getAllGrade();
    for (var item in grades) {
      GradeNumber.value.add(GradeCircle(grade: item));
    }
  }

  getPdfFiles() async {
    filesinfo.value = await references.getPdfInfo();
  }

  //Videos refrences
  var VideosInfo = [].obs;

  getVideos() async {
    VideosInfo.value = await references.getVideos();
  }

  //filtter
  var GradeNumber = [
    /*GradeCircle(grade: 1),
    GradeCircle(grade: 2),
    GradeCircle(grade: 3),
    GradeCircle(grade: 4),
    GradeCircle(grade: 5),*/
  ].obs;
  //Grade  Filtter
  var currentGrade = 0.obs;
  updateGreadeIndex(int index) {
    currentGrade.value = index;
    update();
  }

  //Subject Filtter
  var subjectsName = [
    /* SubjectFiltter(subjectName: 'Art'),
    SubjectFiltter(subjectName: 'Math'),
    SubjectFiltter(subjectName: 'Music'),
    SubjectFiltter(subjectName: 'programming'),*/
  ].obs;

  var currentSubjectIndex = 0.obs;
  var currentSubject = ''.obs;
  updateSubjectIndex(int index) {
    currentSubjectIndex.value = index;
    update();
  }

  //Diffcult Filtter
  var difficulty = [
    DifficultyFiltter(difficulty: 'Easy'),
    DifficultyFiltter(difficulty: 'Medium'),
    DifficultyFiltter(difficulty: 'Hard'),
  ].obs;

  var currenDifficulty = 0.obs;
  updateDifficultyIndex(int index) {
    currenDifficulty.value = index;
    update();
  }

  var filtredDataListPdf = [].obs;
  var filtredDataListVideo = [].obs;
  bool isFiltred = false;

  getFiltredData() async {
    filtredDataListPdf.value = await references.getFiltredDataPdf(
      FiltredData(
        grade: currentGrade.value,
        subject: currentSubject.value,
      ),
    );
    filtredDataListVideo.value = await references.getFiltredDataVideo(
      FiltredData(
        grade: currentGrade.value,
        subject: currentSubject.value,
      ),
    );
    isFiltred = true;
    update();
  }
}
