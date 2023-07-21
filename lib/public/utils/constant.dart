import 'package:flutter/material.dart';

const primaryColor = Color(0xFF636CEF);
const secondaryColor = Color(0xFF939CF5);
const titleColor = Color(0xFF5153C3); // used Only once
const darkGray = Color(0xFF606060); //The main text color
const gray = Color(0xFFA4A4A4);
const lightGray = Color(0xFFD4D4D4);
const black = Color(
    0xFF333333); //used only once I guess, in the Subject Widejt "The total number of lessons at the top"
const blue = Color(0xFF6FA8D7); //used only once
const backgroundColor = Color(0xFFF6F6F6);
const white = Color(0xFFFFFFFF);
const loadingPrimarycolor = Color.fromARGB(255, 192, 195, 236);

class Pics {
  String adminGreyPic = 'assets/images/admin.png';
  String adminWhitePic = 'assets/images/admin-white.png';
  String studentGreyPic = 'assets/images/student.png';
  String studentWhitePic = 'assets/images/student-white.png';
  String teacherGreyPic = 'assets/images/teacher.png';
  String teacherWhitePic = 'assets/images/teacher-white.png';
  String parentGreyPic = 'assets/images/parents.png';
  String parentWhitePic = 'assets/images/parents-white.png';
  String backgroundPic = 'assets/images/login-background-squares.png';
}

// const Map<String, String> pics = {
//   'adminGreyPic': 'assets/images/admin.png',
//   'adminWhitePic': 'assets/images/admin-white.png',
//   'student': 'assets/images/admin.png',
//   'studentWhitePic': 'assets/images/student-white.png',
//   'teacherGreyPic': 'assets/images/teacher.png',
//   'teacherWhitePic': 'assets/images/teacher-white.png',
//   'parentGreyPic': 'assets/images/parents.png',
//   'parentWhitePic': 'assets/images/parents-white.png'
// };

const gradientColor = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    secondaryColor,
    primaryColor,
  ],
);
const gradientColor2 = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Colors.white,
    Colors.white,
  ],
);
