import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';

Widget circuledButton({
  required LinearGradient background,
  double height = 70,
  required String pic,
  required String text,
  required final Function press,
  required Color icontextcolor,
}) =>
    InkWell(
      onTap: () => press.call(),
      child: Container(
          height: height,
          width: height,
          decoration: BoxDecoration(
            gradient: background,
            shape: BoxShape.circle,
            border: Border.all(color: gray),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Image.asset(
                    pic,
                    height: 75,
                    width: 75,
                    fit: BoxFit.cover,
                    color: icontextcolor,
                  ),
                ),
              ),
              Expanded(
                  child: Text(text,
                      style:  TextStyle(fontSize: 12, color: icontextcolor)))
            ],
          )),
    );
