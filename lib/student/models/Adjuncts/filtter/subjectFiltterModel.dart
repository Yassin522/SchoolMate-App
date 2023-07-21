import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectFiltter {
  final subjectName;

  SubjectFiltter({this.subjectName});

  factory SubjectFiltter.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return SubjectFiltter(
      subjectName: data?['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (subjectName != null) "name": subjectName,
    };
  }
}
