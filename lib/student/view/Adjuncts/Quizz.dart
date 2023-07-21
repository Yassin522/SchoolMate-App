import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/student/view/Adjuncts/Component/QuizzPage.dart';

import '../../../public/utils/constant.dart';
import '../../../public/utils/font_families.dart';
import '../../controllers/quizzController.dart';

class Quizzes extends StatefulWidget {
  Quizzes({Key? key}) : super(key: key);

  @override
  State<Quizzes> createState() => _QuizzesState();
}

class _QuizzesState extends State<Quizzes> {
  var _controller = Get.put(QuizzController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _controller.getQuizzes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: _controller.quizes.value.length,
            itemBuilder: (BuildContext context, int index) {
              return QuizCard(
                name: _controller.quizes.value[index].name,
                s_name: _controller.quizes.value[index].subject_name,
                id: _controller.quizes.value[index].quiz_id,
                def: _controller.quizes.value[index].def,
              );
            },
          ),
        );
      },
    );
  }
}

class QuizCard extends StatelessWidget {
  QuizCard({
    Key? key,
    this.def,
    this.id,
    this.name,
    this.s_name,
  }) : super(key: key);
  final id;
  final name;
  final s_name;
  final def;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 18.w,
        right: 18.w,
        top: 18.h,
        bottom: 18.h,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 380.w,
          height: 140.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: white,
          ),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.quiz,
                  size: 25,
                  color: primaryColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Row(
                  children: [
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
                                  '$name',
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
                              'subject',
                              style: const TextStyle(
                                fontFamily: RedHatDisplay.regular,
                                color: gray,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 6.h,
                            ),
                            child: Text(
                              '$def',
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
            ],
          ),
        ),
      ),
    );
  }
}
