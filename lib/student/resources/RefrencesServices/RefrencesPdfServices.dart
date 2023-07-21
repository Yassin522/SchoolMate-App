import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:school_management_system/student/models/Adjuncts/QuizzModel.dart';
import 'package:school_management_system/student/models/Adjuncts/filtter/filteredData.dart';
import 'package:school_management_system/student/models/Adjuncts/filtter/subjectFiltterModel.dart';
import 'package:school_management_system/student/models/Adjuncts/refrencesFiles.dart';
import 'package:school_management_system/student/models/Adjuncts/refrencesVideos.dart';
import 'package:school_management_system/student/view/Adjuncts/refrences.dart';

class RefrencesPdfServices {
  getPdfInfo() async {
    List pdfList = [];
    try {
      final pdfFiles = await FirebaseFirestore.instance
          .collection('reference')
          .where('type', isEqualTo: 'book')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          pdfList.add(RefrencesFiles(
            fileName: element.data()['name'],
            subject: element.data()['subjectName'],
            url: element.data()['url'],
          ));
        });
      });
      return pdfList;
    } catch (e) {
      print('@#@#@#@#@#@#@#@#');
      return [];
    }
  }

  getVideos() async {
    String docID;
    List videosList = [];
    final pdfFiles = await FirebaseFirestore.instance
        .collection('reference')
        .where('type', isEqualTo: 'video')
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        videosList.add(
          RefrencesVideos(
            videoName: element.data()['name'],
            subject: element.data()['name'],
            url: element.data()['url'],
          ),
        );
      });
    });
    return videosList;
  }

  getFiltredDataPdf(FiltredData filter) async {
    var filtredDataList = [].obs;

    var filtredData = await FirebaseFirestore.instance
        .collection('reference')
        .where('subjectName', isEqualTo: filter.subject)
        .where('grade', isEqualTo: filter.grade)
        .where('type', isEqualTo: 'book')
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        filtredDataList.add(RefrencesFiles(
            fileName: value.docs[i].data()["name"],
            subject: value.docs[i].data()["subjectName"]));
      }
    });

    return filtredDataList;
  }

  getFiltredDataVideo(FiltredData filter) async {
    var filtredDataList = [].obs;

    var filtredData = await FirebaseFirestore.instance
        .collection('reference')
        .where('subjectName', isEqualTo: filter.subject)
        .where('grade', isEqualTo: filter.grade)
        .where('type', isEqualTo: 'video')
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        filtredDataList.add(
          RefrencesVideos(
            videoName: value.docs[i].data()["name"],
            subject: value.docs[i].data()["subjectName"],
            url: value.docs[i].data()["url"],
          ),
        );
      }
    });

    return filtredDataList;
  }

  static getQuizzes() async {
    var quizList = [];
    await FirebaseFirestore.instance.collection('quiz').get().then((value) {
      value.docs.forEach((element) {
        quizList.add(QuizzModel(
          def: element.data()['diffculty'],
          subject_name: element.data()['subject_name'],
          quiz_id: element.data()['uid'],
          question: element.data()['question'],
          name: element.data()['name'],
        ));
      });
    });

    return quizList;
  }
}
