import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color redClr = Color(0xFFff0000);
const Color greenClr = Color(0xFF00ff00);
const Color orangeClr = Color(0xFFffa500);
const Color brownClr = Color(0xFF8b4513);
const Color purpleClr = Color(0xFF800080);
const Color blackClr = Color(0xFF000000);
const Color white = Color(0xFFffffff);
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {

  static final light = ThemeData.light().copyWith(
    appBarTheme:const AppBarTheme(
      backgroundColor: white,
    ),
    brightness: Brightness.light,
  );


  static final dark = ThemeData.dark().copyWith(
    appBarTheme:const AppBarTheme(
      backgroundColor: darkGreyClr,
    ),
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
        color: Get.isDarkMode?Colors.grey[400]:Colors.grey
    )
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode?Colors.white:Colors.black

      )
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode?Colors.white:Colors.black

      )
  );
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode? Colors.grey[100]:Colors.grey[600]
      )
  );
}