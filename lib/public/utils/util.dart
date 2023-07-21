import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
