import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/teacher/model/TRefrenceModels/TpdfFilesModel.dart';

import '../../../student/models/Adjuncts/refrencesVideos.dart';
import '../../model/TRefrenceModels/TAddvideoModel.dart';
import '../../model/TRefrenceModels/TpdfAddFileModel.dart';
import '../../view/tasks/AddFiles/components/SelectFile.dart';

class TAdjunctsServices {
  getAllGrade() async {
    var gradeList = [];
    await FirebaseFirestore.instance
        .collection('acadimic_year')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        try {
          gradeList.add(element.data()['grade'].toString());
        } catch (e) {
          print('@#@#@#@#@#@#@#@#@#@#');
          print(e);
        }
      });
    });
    print(gradeList);
    return gradeList;
  }

  getPdfFiles() async {
    var pdfList = [];
    try {
      await FirebaseFirestore.instance
          .collection('reference')
          .where('type', isEqualTo: 'book')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          try {
            pdfList.add(TpdfFilesModel(
              file_id: element.data()['uid'],
              subject_id: element.data()['subject_id'],
              subject_name: element.data()['subjectName'],
              url: element.data()['url'],
              file_name: element.data()['name'],
            ));
          } catch (e) {
            print('#@#@#@#@#@#@#@#@');
            print(e);
          }
        });
      });
      return pdfList;
    } catch (e) {
      print('@#@#@#@#@#@#@#@#');
      print(e);
      return pdfList;
    }
  }

  addFile(TpdfAddFileModel item) async {
    try {
      var id = FirebaseFirestore.instance.collection('reference').doc().id;
      var tname = UserInformation.first_name + ' ' + UserInformation.last_name;
      var dest = '/reference/$tname/pdf/${item.name}';
      var url = await uploadfileToFirebase(file: item.file, destination: dest);
      FirebaseFirestore.instance.collection('reference').doc(id).set({
        'grade': item.grade,
        'name': item.name,
        'subject_id': item.subject_id,
        'subjectName': item.subjectName,
        'type': item.type,
        'id': id.toString(),
        'url': url.toString(),
      });
    } catch (e) {
      print('@#@#@#@#@#@#@#@#');
    }
  }

  getVideos() async {
    var videoslist = [];
    try {
      await FirebaseFirestore.instance
          .collection('reference')
          .where('type', isEqualTo: 'video')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          try {
            videoslist.add(RefrencesVideos(
              videoName: element.data()['name'],
              teacher_name: element.data()['teacher_name'],
              subject: element.data()['subjectName'],
              url: element.data()['url'],
              subject_id: element.data()['subject_id'],
              subject_name: element.data()['subjectName'],
            ));
          } catch (e) {
            print('#@#@#@#@#@#@#@#@');
            print(e);
          }
        });
      });
      return videoslist;
    } catch (e) {
      print('@#@#@#@#@#@#@#@#');
      print(e);
      return videoslist;
    }
  }

  addVideo(AddVideoModel item) async {
    try {
      var id = FirebaseFirestore.instance.collection('reference').doc().id;
      var tname = UserInformation.first_name + ' ' + UserInformation.last_name;
      FirebaseFirestore.instance.collection('reference').doc(id).set({
        'grade': item.grade,
        'name': item.name,
        'subject_id': item.subject_id,
        'subjectName': item.subjectName,
        'type': item.type,
        'id': id.toString(),
        'url': item.url,
        'teacher_id': UserInformation.User_uId,
        'teacher_name': tname,
      });
    } catch (e) {
      print('@#@#@#@#@#@#@#@#');
    }
  }
}
