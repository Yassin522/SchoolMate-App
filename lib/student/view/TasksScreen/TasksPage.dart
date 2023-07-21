import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_style.dart';
import '../../../teacher/view/tasks/TeacherTasksPage.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../controllers/TasksController.dart';

import 'TasksCard.dart';

var _controller = Get.put<TasksController>(TasksController());

class TasksPage extends StatelessWidget {
  final TasksController c = Get.put(TasksController());

  TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    c.getTask();
    var mona = c.tasks;
    print(mona.length);
    print("hhhhhhhhhhhhhhhhhhhhhhhh");
    return SafeArea(
      child: Scaffold(
        // drawer: Drawer(),
        // appBar: CostumAppBar(
        //   title: 'Tasks',
        //   style: redHatRegularStyle(fontSize: 24, color: Colors.white),
        // ),
        body: Column(
          children: [
            Container(
              height: 718.h,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 24.h,
                  left: 15.w,
                  right: 15.w,
                ),
                child: FutureBuilder(
                  future: _controller.getTask(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SimmerTaskLoading(),
                      );
                    } else if (snapshot.hasError) {
                      return SizedBox(
                          width: 540.w * .8,
                          height: 200.h,
                          child: const Expanded(
                              child: Center(
                                  child: Text(
                                      'Somthing went wrong! please check your connection.'))));
                    } else {
                      if (_controller.tasks.value.isEmpty) {
                        return const Center(
                            child: Text('You have no tasks this time'));
                      } else {
                        return GetBuilder<TasksController>(
                          builder: ((controller) {
                            return GridView.builder(
                                dragStartBehavior: DragStartBehavior.down,
                                itemCount: mona.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 24.w,
                                        mainAxisSpacing: 24.w),
                                itemBuilder: (BuildContext, index) {
                                  return Container(
                                    height: 178.h,
                                    width: 178.w,
                                    decoration: BoxDecoration(
                                      gradient: gradientColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TasksCard(
                                      name: controller.tasks.value[index].name,
                                      deadline: controller
                                          .tasks.value[index].deadline,
                                      subjectName: controller
                                          .tasks.value[index].subjectName,
                                      uploadDate: controller
                                          .tasks.value[index].uploadDate,
                                      task_id: controller.tasks.value[index].id,
                                    ),
                                  );
                                });
                          }),
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
