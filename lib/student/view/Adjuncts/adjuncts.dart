import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/public/utils/font_families.dart';
import 'package:school_management_system/public/utils/font_style.dart';
import 'package:school_management_system/student/Widgets/CustomAppBar.dart';
import 'package:school_management_system/student/models/Adjuncts/refrencesChipsdata.dart';
import 'package:school_management_system/student/view/Adjuncts/Quizz.dart';
import 'package:school_management_system/student/view/Adjuncts/Videos.dart';
import 'package:school_management_system/student/view/Adjuncts/refrences.dart';

import 'Component/filtter/filtterButton.dart';

class Refrences extends StatefulWidget {
  const Refrences({Key? key}) : super(key: key);

  @override
  State<Refrences> createState() => _RefrencesState();
}

class _RefrencesState extends State<Refrences> {
  @override
  int _index = 0;
  final adjunctsPage = [
    RefrencesPdf(),
    Quizzes(),
    Videos(),
  ];

  final _chips = [
    ChipsData(
      label: 'Refrences',
    ),
    ChipsData(
      label: 'Quizzes',
    ),
    ChipsData(
      label: 'Videos',
    ),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      /*appBar: CostumAppBar(
        title: 'Adjuncts',
        style: redHatLightStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),*/
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 40.w,
                right: 40.w,
                top: 24.h,
              ),
              child: chosePageBar(),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 116.5.w,
                right: 116.5.w,
                top: 24.h,
                bottom: 15.h,
              ),
              child: const Divider(
                color: Color(0xFFD4D4D4),
              ),
            ),
            FiltterButton(),
            SizedBox(
              height: 24.h,
            ),
            Container(
              height: 555.h,
              child: adjunctsPage[_index], //adjunctsPage[_index],
            ),
          ],
        ),
      ),
    );
  }

  Container chosePageBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          _chips.length,
          (index) => ChoiceChip(
            label: Text(
              '${_chips[index].label.toString()}',
            ),
            labelStyle: (_index == index)
                ? redHatBoldStyle(
                    fontSize: 12,
                    color: Colors.white,
                  )
                : redHatBoldStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
            selected: _index == index,
            selectedColor: primaryColor,
            backgroundColor: Colors.white10,
            onSelected: (bool select) {
              setState(() {
                _index = index;
              });
            },
          ),
        ),
      ),
    );
  }
}



  /*Widget filtterButton() {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          context: context,
          builder: (BuildContext) => Center(
            child: Text('Hello!'),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Fillter',
            style: TextStyle(
              color: primaryColor,
              fontFamily: RedHatDisplay.medium,
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: 7.w,
          ),
          Icon(
            Icons.arrow_drop_down,
            size: 15,
            color: primaryColor,
          ),
        ],
      ),
    );
  }*/

  