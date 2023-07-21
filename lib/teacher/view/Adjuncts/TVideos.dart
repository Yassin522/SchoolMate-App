import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/student/view/Adjuncts/Videos.dart';
import 'package:school_management_system/teacher/controllers/RefrencesControllers/TVideosController.dart';
import 'package:school_management_system/teacher/controllers/RefrencesControllers/TrefrenceBottomSheetController.dart';

import '../../widgets/ConnectionStateMessages.dart';

var _controller = Get.put<TVideosController>(TVideosController());

class TVideos extends StatelessWidget {
  const TVideos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 24.h,
          ),
          child: SizedBox(
            height: 700.h,
            width: 540.w,
            child: GetBuilder<TreferenceBottomsheetController>(
                init: TreferenceBottomsheetController(),
                builder: (controller) {
                  return FutureBuilder(
                    future: _controller.getVideos(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingCircle();
                      } else {
                        return ListView.builder(
                          itemCount: _controller.VideosList.value.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RefrencesVideoCard(
                                url: _controller.VideosList.value[index].url);
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
