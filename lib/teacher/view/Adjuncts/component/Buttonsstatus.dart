import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/teacher/controllers/RefrencesControllers/TPdfRefrencesController.dart';
import 'package:school_management_system/teacher/view/tasks/AddFiles/components/SelectFile.dart';

import '../../../../public/utils/constant.dart';
import '../../../../public/utils/font_families.dart';
import '../../../../student/view/Adjuncts/Component/filtter/filtterComponent/gradefiltter.dart';
import '../../../controllers/RefrencesControllers/TrefrenceBottomSheetController.dart';
import '../../tasks/TeacherTasksPage.dart';
import 'TgradeRefrence.dart';

class Buttons {
  final label;
  final onTap;

  Buttons({this.label, this.onTap});
}

class ButtonsFunctions {
  static var _pdfController = Get.find<TreferenceBottomsheetController>();
  pdfBottomSheetButton(BuildContext context) {
    return Buttons(
      label: 'file',
      onTap: () {
        Get.bottomSheet(
          SizedBox(
            height: Get.size.height * .8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            top: 24.h,
                          ),
                          child: SizedBox(
                            width: 73.w,
                            child: const Text(
                              'Grade',
                              style: TextStyle(
                                color: darkGray,
                                fontFamily: RedHatDisplay.medium,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30.w,
                          ),
                          child: TrefChosingGradeBar(),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            top: 24.h,
                          ),
                          child: SizedBox(
                            width: 100.w,
                            child: const Text(
                              'file name',
                              style: TextStyle(
                                color: darkGray,
                                fontFamily: RedHatDisplay.medium,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            right: 24.w,
                            top: 20.h,
                            bottom: 20.h,
                          ),
                          child: TextField(
                            onChanged: (String value) {
                              print(value);
                              _pdfController.pdf_name.value = value;
                            },
                            decoration: InputDecoration(
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Enter reference name'),
                              ),
                              labelStyle: TextStyle(
                                color: primaryColor,
                                fontSize: 15,
                              ),
                              fillColor: backgroundColor,
                              filled: true,
                              border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(12.0),
                                  borderSide: new BorderSide(
                                      width: 0.0, color: backgroundColor)),
                              contentPadding: EdgeInsets.all(8.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        GetBuilder<TreferenceBottomsheetController>(
                            init: TreferenceBottomsheetController(),
                            builder: (controller) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: 24.w,
                                  right: 24.w,
                                  top: 20.h,
                                  bottom: 20.h,
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: primaryColor, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: primaryColor, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  dropdownColor: backgroundColor,
                                  value: _pdfController.selectedSuject.value,
                                  onChanged: (newValue) {
                                    _pdfController.updateUI(newValue);
                                  },
                                  items: List.generate(
                                      _pdfController.subjectList.value.length,
                                      (index) {
                                    print('this is drop item ' +
                                        _pdfController.subjectList.value[index]
                                            .subjectName
                                            .toString());
                                    return DropdownMenuItem<String>(
                                        value: _pdfController.subjectList
                                            .value[index].subjectName
                                            .toString(),
                                        child: Text(
                                            '${_pdfController.subjectList.value[index].subjectName}'));
                                  }),
                                ),
                              );
                            }),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GetBuilder<TreferenceBottomsheetController>(
                                  init: TreferenceBottomsheetController(),
                                  builder: (controller) {
                                    return Text(
                                        '${_pdfController.fileName.toString()}');
                                  }),
                              MaterialButton(
                                onPressed: () async {
                                  var file = await selectfile();
                                  if (file != null)
                                    _pdfController.updateFile(file);
                                },
                                child: Icon(
                                  Icons.attach_file,
                                  size: 20,
                                  color: gray,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                      ],
                    ),
                  ),
                  AddButton(
                    Bcontext: context,
                    onpress: () {
                      EasyLoading.show();
                      _pdfController.addPdf();
                      Get.back();
                      EasyLoading.showSuccess('Done');
                    },
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          isScrollControlled: true,
        );
      },
    );
  }

  quizBottomSheetButton(BuildContext context) {
    return Buttons(
      label: 'Quiz',
      onTap: () {
        Get.bottomSheet(
          SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 24.w,
                          top: 24.h,
                        ),
                        child: SizedBox(
                          width: 73.w,
                          child: const Text(
                            'Grade',
                            style: TextStyle(
                              color: darkGray,
                              fontFamily: RedHatDisplay.medium,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30.w,
                        ),
                        child: const ChosingGradeBar(),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 24.w,
                          top: 24.h,
                        ),
                        child: SizedBox(
                          width: 100.w,
                          child: const Text(
                            'Video name',
                            style: TextStyle(
                              color: darkGray,
                              fontFamily: RedHatDisplay.medium,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 24.w,
                          right: 24.w,
                          top: 20.h,
                          bottom: 20.h,
                        ),
                        child: TextField(
                          onChanged: (String value) {
                            print(value);
                            _pdfController.pdf_name.value = value;
                          },
                          decoration: InputDecoration(
                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Enter reference name'),
                            ),
                            labelStyle: TextStyle(
                              color: primaryColor,
                              fontSize: 15,
                            ),
                            fillColor: backgroundColor,
                            filled: true,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(12.0),
                                borderSide: new BorderSide(
                                    width: 0.0, color: backgroundColor)),
                            contentPadding: EdgeInsets.all(8.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Add file'),
                            MaterialButton(
                              onPressed: () {},
                              child: Icon(
                                Icons.attach_file,
                                size: 20,
                                color: gray,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
                AddButton(
                  Bcontext: context,
                ),
              ],
            ),
          ),
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          isScrollControlled: true,
        );
      },
    );
  }

  videoBottomSheetButton(BuildContext context) {
    return Buttons(
      label: 'Video',
      onTap: () {
        Get.bottomSheet(
          SizedBox(
            height: Get.size.height * .8,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            top: 24.h,
                          ),
                          child: SizedBox(
                            width: 73.w,
                            child: const Text(
                              'Grade',
                              style: TextStyle(
                                color: darkGray,
                                fontFamily: RedHatDisplay.medium,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30.w,
                          ),
                          child: TrefChosingGradeBar(),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            top: 24.h,
                          ),
                          child: SizedBox(
                            width: 100.w,
                            child: const Text(
                              'Video name',
                              style: TextStyle(
                                color: darkGray,
                                fontFamily: RedHatDisplay.medium,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            right: 24.w,
                            top: 20.h,
                            bottom: 20.h,
                          ),
                          child: TextField(
                            onChanged: (String value) {
                              print(value);
                              _pdfController.video_name.value = value;
                            },
                            decoration: InputDecoration(
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Enter video name'),
                              ),
                              labelStyle: TextStyle(
                                color: primaryColor,
                                fontSize: 15,
                              ),
                              fillColor: backgroundColor,
                              filled: true,
                              border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(12.0),
                                  borderSide: new BorderSide(
                                      width: 0.0, color: backgroundColor)),
                              contentPadding: EdgeInsets.all(8.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            top: 24.h,
                          ),
                          child: SizedBox(
                            width: 73.w,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: const Text(
                                'Subject',
                                style: TextStyle(
                                  color: darkGray,
                                  fontFamily: RedHatDisplay.medium,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        GetBuilder<TreferenceBottomsheetController>(
                            init: TreferenceBottomsheetController(),
                            builder: (controller) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: 24.w,
                                  right: 24.w,
                                  top: 20.h,
                                  bottom: 20.h,
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: primaryColor, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: primaryColor, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  dropdownColor: backgroundColor,
                                  value: _pdfController.selectedSuject.value,
                                  onChanged: (newValue) {
                                    _pdfController.updateUI(newValue);
                                  },
                                  items: List.generate(
                                      _pdfController.subjectList.value.length,
                                      (index) {
                                    return DropdownMenuItem<String>(
                                        value: _pdfController.subjectList
                                            .value[index].subjectName
                                            .toString(),
                                        child: Text(
                                            '${_pdfController.subjectList.value[index].subjectName}'));
                                  }),
                                ),
                              );
                            }),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 24.w,
                            top: 24.h,
                          ),
                          child: SizedBox(
                            width: 73.w,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: const Text(
                                'Video Url ',
                                style: TextStyle(
                                  color: darkGray,
                                  fontFamily: RedHatDisplay.medium,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Get.size.width * .7,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 15.w,
                                    right: 15.w,
                                    top: 20.h,
                                    bottom: 20.h,
                                  ),
                                  child: TextField(
                                    onChanged: (String value) {
                                      print(value);
                                      _pdfController.video_url.value = value;
                                    },
                                    decoration: InputDecoration(
                                      label: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Enter video url'),
                                      ),
                                      labelStyle: TextStyle(
                                        color: primaryColor,
                                        fontSize: 15,
                                      ),
                                      fillColor: backgroundColor,
                                      filled: true,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(12.0),
                                          borderSide: new BorderSide(
                                              width: 0.0,
                                              color: backgroundColor)),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () async {},
                                child: Icon(
                                  Icons.paste_outlined,
                                  size: 20,
                                  color: gray,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                      ],
                    ),
                  ),
                  AddButton(
                    Bcontext: context,
                    onpress: () async {
                      EasyLoading.show();
                      await _pdfController.addVideo();
                      Get.back();
                      EasyLoading.showSuccess('Done');
                    },
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          isScrollControlled: true,
        );
      },
    );
  }

  getButtons(int index, BuildContext context) {
    var buttons = [
      pdfBottomSheetButton(context),
      quizBottomSheetButton(context),
      videoBottomSheetButton(context),
    ];
    return buttons[index];
  }
}
