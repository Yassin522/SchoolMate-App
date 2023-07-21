

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../public/utils/font_style.dart';
import '../../../student/Widgets/CustomAppBar.dart';
import '../../../student/controllers/TasksController.dart';
import 'package:school_management_system/student/view/TasksScreen/TasksPage.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CostumAppBar(),
          body: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 40.0),
                  child: RaisedButton(
                    color: Colors.white,
                      padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                   onPressed: () {  },
                   child:Text ("ADD FILE + ")

                  )
                  )
              ],
                    ),
          ),

        ),
              );



  }
}
