import 'package:cloud_firestore/cloud_firestore.dart';

class RefrencesFiles {
  final fileName;
  final subject;
  var file_id;
  var subject_id;
  var url;

  RefrencesFiles({this.fileName, this.subject, this.url});

  static fromJson(Map<String, dynamic> json) {
    return RefrencesFiles(
      fileName: json['name'],
      subject: json['subject'],
    );
  }

  factory RefrencesFiles.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return RefrencesFiles(
      fileName: data?['name'],
      subject: data?['state'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (fileName != null) "name": fileName,
      if (subject != null) "subject": subject,
    };
  }
}
