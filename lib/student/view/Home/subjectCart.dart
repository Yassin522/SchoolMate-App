import 'package:flutter/material.dart';

import '../../../public/utils/font_style.dart';

class SubjectDetails extends StatelessWidget {
  const SubjectDetails({
    this.subjectName,
    this.teacherName,
    Key? key,
  }) : super(key: key);

  final subjectName;
  final teacherName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$subjectName",
            style: sfBoldStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "$teacherName",
            style: sfBoldStyle(fontSize: 10, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
