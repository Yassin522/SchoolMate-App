import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/student/view/Adjuncts/refrences.dart';
import 'package:school_management_system/teacher/controllers/RefrencesControllers/TPdfRefrencesController.dart';
import 'package:school_management_system/teacher/widgets/ConnectionStateMessages.dart';

var _controller = Get.find<TRefrencesPdfController>();

class TeacherPdfRefrences extends StatelessWidget {
  const TeacherPdfRefrences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          height: 600.h,
          width: 500.w,
          child: GetBuilder<TRefrencesPdfController>(
            init: TRefrencesPdfController(),
            builder: ((controller) {
              return FutureBuilder(
                future: _controller.getPdfFiles(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingCircle();
                  } else {
                    return ListView.builder(
                      itemCount: _controller.pdfList.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RefrenecesFileCard(
                          filename: _controller.pdfList.value[index].file_name,
                          subject:
                              _controller.pdfList.value[index].subject_name,
                          url: _controller.pdfList.value[index].url,
                        );
                      },
                    );
                  }
                },
              );
            }),
          )),
    );
  }
}
