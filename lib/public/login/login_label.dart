import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constant.dart';

class Loginlabel extends StatelessWidget {
  const Loginlabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
     child: Text(
       "SchoolMate",
       style: GoogleFonts.redHatDisplay(
         textStyle: const TextStyle(
           color: titleColor,
           fontWeight: FontWeight.w900,
           fontSize: 34,
         ),
       ),
     ),
  );
  }
}