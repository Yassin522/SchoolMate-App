import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/public/utils/font_style.dart';
import 'package:school_management_system/student/Widgets/CustomAppBar.dart';
import 'package:school_management_system/student/Widgets/custom_progress_indecator.dart';
import 'package:school_management_system/student/Widgets/global_info.dart';
import 'package:school_management_system/teacher/controllers/TProfilesController/DropMenuController.dart';
import 'package:school_management_system/teacher/controllers/TProfilesController/SProfileController.dart';
import 'package:school_management_system/teacher/widgets/ConnectionStateMessages.dart';
import 'package:school_management_system/teacher/widgets/Skilton.dart';
import 'package:shimmer/shimmer.dart';

var _controller = Get.put(SProfileController());
var data = Get.arguments;
var dropController = Get.put(DropMenuController());

class SProfileScreen extends StatelessWidget {
  const SProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.stId.value = data[0];
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: CostumAppBar(title: "Profile"),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: _controller.getStudentsInfoForTeacher(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SProfileShimmerLoading();
              } else {
                if (snapshot.hasError) {
                  return ErrorMessage();
                } else {
                  return GetBuilder(
                    init: SProfileController(),
                    builder: ((controller) {
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.h,
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 135,
                                width: 135,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(_controller
                                        .studentInfo.value.url
                                        .toString()),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -20,
                                top: 65,
                                left: 100,
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white),
                                    gradient: gradientColor,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      //c.selectImage();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(_controller.studentInfo.value.fname.toString(),
                              style: redHatMediumStyle(
                                  fontSize: 20, color: Colors.black)),
                          const SizedBox(
                            height: 8,
                          ),
                          Text('Student',
                              style: redHatMediumStyle(
                                  fontSize: 20, color: primaryColor)),
                          const SizedBox(
                            height: 30,
                          ),
                          GlobalInfo(
                              fullname: "Full name",
                              name:
                                  '${_controller.studentInfo.value.fname} ${_controller.studentInfo.value.lname}',
                              icon: Icons.person),
                          const Divider(
                            indent: 65,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.school,
                                      color: gray,
                                      size: 27,
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Grade',
                                            style: redHatMediumStyle(
                                                fontSize: 11, color: gray)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            _controller.studentInfo.value.grade
                                                .toString(),
                                            maxLines: 10,
                                            overflow: TextOverflow.ellipsis,
                                            style: redHatMediumStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.class_,
                                      color: gray,
                                      size: 27,
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Class',
                                            style: redHatMediumStyle(
                                                fontSize: 11, color: gray)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            _controller
                                                .studentInfo.value.classroom
                                                .toString(),
                                            maxLines: 10,
                                            overflow: TextOverflow.ellipsis,
                                            style: redHatMediumStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            indent: 65,
                          ),
                          GlobalInfo(
                            fullname: "PhoneNumber",
                            name:
                                _controller.studentInfo.value.phone.toString(),
                            icon: Icons.call,
                          ),
                          const Divider(
                            indent: 65,
                          ),
                          GlobalInfo(
                            fullname: "Parent",
                            name: _controller.studentInfo.value.paretnPhone
                                .toString(),
                            icon: Icons.people,
                          ),
                          const Divider(
                            indent: 65,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: white,
                              height: 370.h,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ProgressIndecator(
                                      precentage:
                                          _controller.studentInfo.value.avrg,
                                    ),
                                    SizedBox(
                                      height: 35.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 50.w),
                                        SizedBox(
                                          width: 100.w,
                                          child: const Center(
                                            child: Text(
                                              'HomeWork',
                                              style: TextStyle(
                                                  color: darkGray,
                                                  fontFamily:
                                                      RedHatDisplay.medium),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50.w,
                                          child: const Center(
                                            child: Text(
                                              'Exam1',
                                              style: TextStyle(
                                                  color: darkGray,
                                                  fontFamily:
                                                      RedHatDisplay.medium),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50.w,
                                          child: const Center(
                                            child: Text(
                                              'Test',
                                              style: TextStyle(
                                                  color: darkGray,
                                                  fontFamily:
                                                      RedHatDisplay.medium),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 70.w,
                                          child: const Center(
                                            child: Text(
                                              'Exam2',
                                              style: TextStyle(
                                                  color: darkGray,
                                                  fontFamily:
                                                      RedHatDisplay.medium),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 23.h,
                                    ),
                                    SizedBox(
                                        height: 200.h,
                                        width: 540.w,
                                        child: GetBuilder(
                                          init: DropMenuController(),
                                          builder: (controller) {
                                            return FutureBuilder(
                                              future: _controller
                                                  .getStudentsInfoForTeacher(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ListView.builder(
                                                    itemCount: _controller
                                                        .studentMarks.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return SubjectMarksCard(
                                                        subjectname: _controller
                                                            .studentMarks
                                                            .value[index]
                                                            .subjectname,
                                                        test: _controller
                                                            .studentMarks
                                                            .value[index]
                                                            .test,
                                                        homework: _controller
                                                            .studentMarks
                                                            .value[index]
                                                            .homework,
                                                        exam1: _controller
                                                            .studentMarks
                                                            .value[index]
                                                            .exam1,
                                                        exam2: _controller
                                                            .studentMarks
                                                            .value[index]
                                                            .exam2,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        )),
                                    SizedBox(
                                      height: 20.h,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 100.h,
                              width: 200.w,
                              child: Container(
                                alignment: Alignment.centerRight,
                                height: 50.0,
                                margin: EdgeInsets.all(10),
                                child: RaisedButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                      textConfirm: 'Add',
                                      onConfirm: () {
                                        print('confirm');
                                        dropController.grade.value = _controller
                                            .studentInfo.value.grade
                                            .toString();
                                        dropController.uid.value =
                                            _controller.studentInfo.value.uid;
                                        dropController.addMark();
                                        Get.back();
                                      },
                                      onCancel: () {},
                                      buttonColor: primaryColor,
                                      textCancel: 'Dismiss',
                                      cancelTextColor: black,
                                      title: 'New Mark',
                                      content: Column(
                                        children: [
                                          DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: primaryColor,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: primaryColor,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            dropdownColor: backgroundColor,
                                            value: dropController
                                                .selectedValue.value,
                                            onChanged: (newValue) {
                                              dropController.updateUI(newValue);
                                            },
                                            items: List.generate(
                                                dropController.subjectNames
                                                    .length, (index) {
                                              print('this is drop item ' +
                                                  dropController
                                                      .subjectNames.value[index]
                                                      .toString());
                                              return DropdownMenuItem<String>(
                                                  value: dropController
                                                      .subjectNames.value[index]
                                                      .toString(),
                                                  child: Text(
                                                      '${dropController.subjectNames.value[index]}'));
                                            }),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: primaryColor,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: primaryColor,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            dropdownColor: backgroundColor,
                                            value: dropController
                                                .selectedType.value,
                                            onChanged: (newValue) {
                                              dropController
                                                  .updatetype(newValue);
                                            },
                                            items: List.generate(
                                                dropController.markType.length,
                                                (index) {
                                              return DropdownMenuItem<String>(
                                                  value: dropController
                                                      .markType.value[index]
                                                      .toString(),
                                                  child: Text(
                                                    '${dropController.markType.value[index]}',
                                                  ));
                                            }),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  onChanged: (String value) {
                                                    print(value);
                                                    dropController.mark.value =
                                                        value;
                                                  },
                                                  decoration: InputDecoration(
                                                    label: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text('Enter mark'),
                                                    ),
                                                    labelStyle: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 15,
                                                    ),
                                                    fillColor: backgroundColor,
                                                    filled: true,
                                                    border: new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(12.0),
                                                        borderSide: new BorderSide(
                                                            width: 0.0,
                                                            color:
                                                                backgroundColor)),
                                                    contentPadding:
                                                        EdgeInsets.all(8.0),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  onChanged: (String value) {
                                                    dropController.fmark.value =
                                                        value;
                                                  },
                                                  decoration: InputDecoration(
                                                    label: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          'Enter full mark'),
                                                    ),
                                                    labelStyle: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 15,
                                                    ),
                                                    fillColor: backgroundColor,
                                                    filled: true,
                                                    border: new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(12.0),
                                                        borderSide: new BorderSide(
                                                            width: 0.0,
                                                            color:
                                                                backgroundColor)),
                                                    contentPadding:
                                                        EdgeInsets.all(8.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: gradientColor,
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: 250.0, minHeight: 50.0),
                                      alignment: Alignment.center,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Add Mark",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            Icon(Icons.add, color: white),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                        ],
                      );
                    }),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

class SProfileShimmerLoading extends StatelessWidget {
  const SProfileShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: loadingPrimarycolor,
      child: Column(
        children: [
          SizedBox(
            height: 300.h,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Skilton(
                    height: 135.h,
                    width: 135.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Skilton(
                    height: 50.h,
                    width: 100.w,
                    decoration: BoxDecoration(color: white),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Skilton(
                    height: 50.h,
                    width: 100.w,
                    decoration: BoxDecoration(color: white),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Skilton(
                height: 100.h,
                width: 300.w,
                decoration: BoxDecoration(color: white),
              ),
            ),
          ),
          SizedBox(
            height: 100.h,
            width: 540.w,
            child: Row(
              children: [
                Expanded(
                  child: Skilton(
                    height: 100.h,
                    width: 90.w,
                    decoration: BoxDecoration(color: white),
                  ),
                ),
                Expanded(
                  child: Skilton(
                    height: 100.h,
                    width: 90.w,
                    decoration: BoxDecoration(color: white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Skilton(
              height: 100.h,
              width: 200.w,
              decoration: BoxDecoration(color: white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Skilton(
              height: 100.h,
              width: 200.w,
              decoration: BoxDecoration(color: white),
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectMarksCard extends StatelessWidget {
  const SubjectMarksCard({
    Key? key,
    this.exam1,
    this.exam2,
    this.homework,
    this.subjectname,
    this.test,
  }) : super(key: key);
  final subjectname;
  final test;
  final homework;
  final exam1;
  final exam2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 70.w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$subjectname',
                style: TextStyle(
                  color: primaryColor,
                  fontFamily: RedHatDisplay.medium,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(width: 25.w),
          SizedBox(
            child: Center(
              child: Text(
                '$homework',
                style: TextStyle(
                    color: darkGray, fontFamily: RedHatDisplay.medium),
              ),
            ),
          ),
          SizedBox(width: 70.w),
          SizedBox(
            child: Center(
              child: Text(
                '$exam1',
                style: TextStyle(
                    color: darkGray, fontFamily: RedHatDisplay.medium),
              ),
            ),
          ),
          SizedBox(width: 60.w),
          SizedBox(
            child: Center(
              child: Text(
                '$test',
                style: TextStyle(
                    color: darkGray, fontFamily: RedHatDisplay.medium),
              ),
            ),
          ),
          SizedBox(width: 50.w),
          SizedBox(
            child: Center(
              child: Text(
                '$exam2',
                style: TextStyle(
                    color: darkGray, fontFamily: RedHatDisplay.medium),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
