import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/student/resources/chat/chat_api.dart';
import 'package:school_management_system/student/resources/task/task_api.dart';
import 'package:school_management_system/teacher/view/tasks/index.dart';
import '../../../public/utils/font_families.dart';
import '../../../public/utils/font_style.dart';
import '../../../public/utils/util.dart';
import '../../../teacher/view/tasks/AddFiles/components/SelectFile.dart';
import '../../controllers/TasksController.dart';
import 'dart:io';
import 'package:path/path.dart';

File? file;
var _controller = Get.put<TasksController>(TasksController());
var tasks = _controller.tasks;
var re = taskServices();
UploadTask? task;

class TasksCard extends StatelessWidget {
  const TasksCard({
    Key? key,
    required this.subjectName,
    required this.name,
    required this.uploadDate,
    required this.deadline,
    this.task_id,
    this.url,
  }) : super(key: key);

  final subjectName;
  final name;
  final uploadDate;
  final deadline;
  final task_id;
  final url;
  @override
  void initState() {
    print('Helooooooooooooooooooo');
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'no file';
    _controller.task_id.value = task_id;
    _controller.task_name.value = name;
    print("kkkkkkkkkkkkkkkkkkkkkkk");
    return Container(
        width: 200.w,
        child: GetBuilder(
          init: TasksController(),
          builder: ((controller) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 15.w,
                      top: 24.h,
                      bottom: 2.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 70.w,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${subjectName}',
                              textAlign: TextAlign.start,
                              style: redHatBoldStyle(
                                  fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70.w,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('$name',
                                textAlign: TextAlign.start,
                                style: redHatLightStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15.h,
                    ),
                    child: SizedBox(
                      height: 30.h,
                      child: DropdownButton(
                        underline: Text(''),
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(
                          Icons.menu,
                          size: 20,
                          color: Colors.white,
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Donwload task',
                            onTap: () async {
                              print("downloadddddddd");
                              showSnackBar('Starting download...', context);
                              /*openFile(
                      url: '${gProgram.url}',
                      fileName: '${gProgram.type}',
                      );*/
                              /*try{ final taskId = await FlutterDownloader.enqueue(
                      url: '${widget.gProgram.url}',
                      savedDir:
                          '/data/user/0/com.example.school_management_system/files/',
                      showNotification:
                          true, // show download progress in status bar (for Android)
                      openFileFromNotification:
                          true, // click on notification to open downloaded file (for Android)
                      );
                     }catch(e){
                      print(e);
                     }*/

                              final baseStorage =
                                  await getExternalStorageDirectory();
                              final id = await FlutterDownloader.enqueue(
                                url: '${url}',
                                savedDir: baseStorage!.path,
                                fileName: '$name',
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Download Task'),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Icon(
                                  Icons.file_download,
                                  color: primaryColor,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              await Get.dialog(Container(
                                color: Colors.greenAccent,
                              ));
                              print('is Open');
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Upload task solution"),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 100.h,
                                        width: 300.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GetBuilder(
                                              init: TasksController(),
                                              builder: (_) => SizedBox(
                                                width: 150.w,
                                                child: Text(
                                                  "${_controller.file_name.value.toString()}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            MaterialButton(
                                              padding: EdgeInsets.all(0),
                                              child: Icon(Icons.attach_file),
                                              onPressed: () async {
                                                var file = await selectfile();
                                                _controller.updateFile(file);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                        child: Text(
                                          "Dismiss",
                                          style: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontFamily: RedHatDisplay.medium,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        color: Colors.redAccent,
                                        child: Text("Upload",
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 18,
                                              fontFamily: RedHatDisplay.medium,
                                            )),
                                        onPressed: () async {
                                          EasyLoading.show();
                                          await _controller.uploadTaskResult();
                                          Navigator.of(context).pop();
                                          EasyLoading.showSuccess('Done');
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            value: 'Upload solution',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Upload solution'),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Icon(
                                  Icons.upload_file,
                                  color: primaryColor,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 95.w,
                      top: 124.h,
                      right: 10.w,
                      bottom: 16.h.h,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 35.h),
                        child: Column(
                          children: [
                            Container(
                              width: 70.w,
                              height: 13.h,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_drop_up,
                                    size: 15.h,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '$uploadDate',
                                    style: redHatRegularStyle(
                                      fontSize: 12.h,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Container(
                              width: 70.w,
                              height: 13.h,
                              child: Row(children: [
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 15.h,
                                  color: Colors.white,
                                ),
                                Text(
                                  '$deadline',
                                  style: redHatRegularStyle(
                                    fontSize: 12.h,
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ));
  }
}
