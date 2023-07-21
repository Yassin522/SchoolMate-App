
import 'package:flutter/material.dart';

import 'constant.dart';
import 'font_families.dart';


TextStyle getTextStyle({ fontFamily ,double? fontSize, Color? color})
{
  return TextStyle(fontFamily: fontFamily,fontSize: fontSize,color: color);
}

TextStyle redHatRegularStyle({double?fontSize=12, color=darkGray})
{
  return getTextStyle(
    fontFamily: RedHatDisplay.regular,
    fontSize: fontSize,
    color: color
  );
}

TextStyle redHatLightStyle({double?fontSize=12, color=darkGray})
{
  return getTextStyle(
    fontFamily: RedHatDisplay.light,
    fontSize: fontSize,
    color: color
  );
}

TextStyle redHatMediumStyle({double?fontSize=12, color=darkGray})
{
  return getTextStyle(
    fontFamily: RedHatDisplay.medium,
    fontSize: fontSize,
    color: color
  );
}

TextStyle redHatBoldStyle({double?fontSize=12, color=darkGray})
{
  return getTextStyle(
    fontFamily: RedHatDisplay.bold,
    fontSize: fontSize,
    color: color
  );
}

TextStyle sfRegularStyle({double?fontSize=12, color=darkGray})
{
  return getTextStyle(
    fontFamily: SFPro.regular,
    fontSize: fontSize,
    color: color
  );
}

TextStyle sfMediumStyle({double?fontSize=12, color=darkGray})
{
  return getTextStyle(
    fontFamily: SFPro.medium,
    fontSize: fontSize,
    color: color
  );
}

TextStyle sfBoldStyle({double?fontSize=12, color=darkGray})
{
  return getTextStyle(
    fontFamily: SFPro.bold,
    fontSize: fontSize,
    color: color
  );
}