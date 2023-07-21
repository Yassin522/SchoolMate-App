import 'package:cloud_firestore/cloud_firestore.dart';

class TAnnouncementsServices {
  getAnnouncements() async {
    var stream = await FirebaseFirestore.instance
        .collection('announcement')
        .where('type', isEqualTo: 'Teachers')
        .snapshots();

    return stream;
  }
}
