import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../public/config/user_information.dart';
import '../../../student/models/programs/programModel.dart';

class ProgramApiT{

  static getNewPrograms()async{
      
       List allPrograms = [];

    await FirebaseFirestore.instance
        .collection('teacherProgram')
        .where('teacher',isEqualTo: UserInformation.User_uId)
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        allPrograms.add(
          Program(
             id: value.docs[i]['id'],
             type: value.docs[i]['type'],
             url: value.docs[i]['url'],
             date: value.docs[i]['date'],
          ),
        );
      }
    });
    return allPrograms;
  }

}