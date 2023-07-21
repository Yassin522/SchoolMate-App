import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/student/controllers/RefrencesController.dart';
import 'package:get/get.dart';
import 'package:school_management_system/student/models/Adjuncts/refrencesFiles.dart';
import 'package:school_management_system/student/resources/RefrencesServices/RefrencesPdfServices.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../teacher/view/tasks/AddFiles/components/SelectFile.dart';
import '../../../teacher/view/tasks/studentsOfTask.dart';

var _controller = Get.put(RefrencesController());
var _filesInfo = _controller.filesinfo;

var re = RefrencesPdfServices();

class RefrencesPdf extends StatelessWidget {
  const RefrencesPdf({Key? key}) : super(key: key);

  @override
  void initState() {
    print('Helooooooooooooooooooo');
  }

  @override
  Widget build(BuildContext context) {
    print(_controller.filesinfo.value);
    _controller.getPdfFiles();
    print(_controller.filesinfo.value);
    return SingleChildScrollView(
      child: SizedBox(
          height: 600.h,
          width: 500.w,
          child: GetBuilder(
            init: RefrencesController(),
            builder: ((controller) {
              return FutureBuilder(
                  future: _controller.getPdfFiles(),
                  builder: ((context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return ShimmerPdfLoading();
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: _controller.isFiltred
                            ? _controller.filtredDataListPdf.value.length
                            : _controller.filesinfo.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          _controller.getPdfFiles();
                          if (_controller.filesinfo.isEmpty) {
                            return const Center(
                              child: Text('Loading...'),
                            );
                          } else {
                            if (!_controller.isFiltred) {
                              return RefrenecesFileCard(
                                filename:
                                    _controller.filesinfo.value[index].fileName,
                                subject:
                                    _controller.filesinfo.value[index].subject,
                                url: _controller.filesinfo.value[index].url,
                              );
                            } else {
                              if (_controller.filtredDataListPdf.isNotEmpty) {
                                return RefrenecesFileCard(
                                  filename: _controller
                                      .filtredDataListPdf.value[index].fileName,
                                  subject: _controller
                                      .filtredDataListPdf.value[index].subject,
                                  url: _controller
                                      .filtredDataListPdf.value[index].url,
                                );
                              } else
                                return Center(
                                  child: Text('Nothing to show'),
                                );
                            }
                          }
                        },
                      );
                    }
                  }));
            }),
          )),
    );
  }
}

class ShimmerPdfLoading extends StatelessWidget {
  const ShimmerPdfLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Padding(
            padding: EdgeInsets.only(
              left: 18.w,
              right: 18.w,
              top: 18.h,
              bottom: 18.h,
            ),
            child: Container(
              width: 380.w,
              height: 120.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: white,
              ),
            )),
        baseColor: Colors.grey.shade100,
        highlightColor: loadingPrimarycolor);
  }
}

class RefrenecesFileCard extends StatelessWidget {
  const RefrenecesFileCard({
    Key? key,
    this.filename,
    this.subject,
    this.url,
  }) : super(key: key);

  @override
  final filename;
  final subject;
  final url;
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 18.w,
        right: 18.w,
        top: 18.h,
        bottom: 18.h,
      ),
      child: Container(
        width: 380.w,
        height: 120.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Row(
                children: [
                  Icon(
                    Icons.bookmark_added_outlined,
                    size: 25,
                    color: primaryColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 30.h,
                      left: 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 6.h,
                          ),
                          child: Container(
                            width: 225.w,
                            height: 30.h,
                            child: FittedBox(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '$filename',
                                maxLines: 1,
                                style: const TextStyle(
                                  fontFamily: RedHatDisplay.medium,
                                  color: darkGray,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 6.h,
                          ),
                          child: Text(
                            '$subject',
                            style: const TextStyle(
                              fontFamily: RedHatDisplay.regular,
                              color: gray,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 16.w,
                top: 10.h,
                bottom: 0.h,
              ),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () async {
                      print(url);
                      print(filename);
                      /* var file = await downloadFile(url, filename);
                      print(file!.path);
                      Get.snackbar(
                          'Downloading...', '${filename} is downloading');
                      await showNotification(
                        filename,
                        file.path,
                      );*/

                      var status = await Permission.storage.status;
                      if (!status.isGranted) {
                        await Permission.storage.request();
                      }
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                      /*var tempDir = await getTemporaryDirectory();
                      String fullPath = tempDir.path + "/boo2.pdf'";
                      print('full path ${fullPath}');

                      var dio = Dio();
                      await download2(dio, url, fullPath);
*/
                      Get.snackbar(
                          'Downloading...', '${filename} is downloading');
                      EasyLoading.show();
                      await openFile(url: url, fileName: filename);
                      EasyLoading.showSuccess('Done!');
                    },
                    icon: const Icon(
                      Icons.downloading,
                      color: gray,
                      size: 25,
                    ),
                  ),
                  const Text(
                    'Download',
                    style: TextStyle(
                      color: gray,
                      fontFamily: RedHatDisplay.regular,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future download2(Dio dio, String url, String savePath) async {
  try {
    var response = await dio.get(
      url,
      onReceiveProgress: showDownloadProgress,
      //Received data with List<int>
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    print(response.headers);
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    raf.writeFromSync(response.data);
    await raf.close();
  } catch (e) {
    print(e);
  }
}

void showDownloadProgress(received, total) {
  if (total != -1) {
    print((received / total * 100).toStringAsFixed(0) + "%");
  }
}
