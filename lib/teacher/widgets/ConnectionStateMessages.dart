import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150.h,
        width: 150.w,
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 20.h,
            ),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Somthing goes wrong please try again'),
    );
  }
}
