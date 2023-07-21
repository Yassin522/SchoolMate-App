import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:school_management_system/public/config/user_information.dart';
import 'package:school_management_system/student/models/Announcements/AnnouncementsModel.dart';

class AnnouncementsServeces {
  getUserClassroom() async {
    var userId = UserInformation.User_uId;
    String userclassroomId = '';
    await FirebaseFirestore.instance
        .collection('students')
        .doc(userId)
        .get()
        .then((value) {
      if (value.data() != null) {
        userclassroomId = value.data()!["class"].id;
      }
      print('Serverss');
      print(userclassroomId);
    });
    print(userclassroomId.toString());
    return userclassroomId;
  }

  /*Stream<List<AnnouncementsModesl>> annoStream() {
    return FirebaseFirestore.instance
        .collection('announcement')
        .doc()
        .snapshots()
        .map((DocumentSnapshot<Map<String, dynamic>> query) {
      var annList = <AnnouncementsModesl>[];
      for (var i = 0; i < query.data()!.length; i++) {
        if (query.data()![i]['class-room-id'].id == getUserClassroom()) {
          final DateTime docDateTime =
              DateTime.parse(query.data()![i]['date'].toDate().toString());
          var annoDate = DateFormat("yyyy/MM/dd").format(docDateTime);
          annList.add(AnnouncementsModesl(
            title: query.data()![i]['title'],
            content: query.data()![i]['content'],
            date: annoDate,
          ));
        }
      }
      return annList;
    });
  }*/

  getUserAnn() {
    /*Stream<QuerySnapshot> announcementFromFirebase =
        FirebaseFirestore.instance.collection('announcement').snapshots();

    return announcementFromFirebase.map((event) {
      return event.docs.map((doc) {
        return AnnouncementsModesl(
          title: doc.data['title'],
          content: doc.data['content'],
          date: doc.data['date'],
        );
      });
    }).toList();*/
  }

  /* for (var i = 0; i < doc.length; i++) {
        if (doc[i].data()['class-room-id'].id.toString() ==
            userclassroomId.toString()) {
          
        }
      }
      */
}
