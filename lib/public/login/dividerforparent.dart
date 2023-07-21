import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_style.dart';

class DividerParent extends StatelessWidget {
  const DividerParent({
    required String text,
    Key? key, 
  }) : _text=text, super(key: key);

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 18.0, right: 20.0),
            child: const Divider(
              color: black,
              height: 36,
            )),
      ),
       Text(
        _text,
        style: sfMediumStyle(fontSize: 12, color: black),
       ),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 18.0),
            child: const Divider(
              color: black,
              height: 36,
            )),
      ),
    ]);
  }
}
