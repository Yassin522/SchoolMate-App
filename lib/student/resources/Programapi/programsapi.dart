import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/student/models/programs/programModel.dart';

class ProgramApi{

  static getNewPrograms()async{
      
       List allPrograms = [];

    await FirebaseFirestore.instance
        .collection('classProgram')
        .where('class-room',isEqualTo: UserInformation.classid)
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