import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomThemeData {
  static TextStyle generateStyle(
      {required double fontSize,
      FontWeight fontWeight = FontWeight.normal,
      Color color = Colors.black}) {
    return GoogleFonts.nunito(
      
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static LinearGradient linearGradient = LinearGradient(
    colors: [
      Color(0xff0b97a0),
      Color(0xff6686c2),
    ],
  );

   static LinearGradient appBarGradient = LinearGradient(
    colors: [
      Color(0xff0F96A1),
      Color(0xff5887BC),
    ],
  );

  static LinearGradient dashGradient = LinearGradient(
    colors: [
      Color(0xff1E93A7),
      Color(0xff7881C8),
    ],
  );


  static LinearGradient buttonGradient = LinearGradient(
    colors: [
      Color(0xff2192A9),
      Color(0xff468BB6),
    ],
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xffe5e5e5),
    primaryColor: Color(0xff0b959e),
    buttonColor: Color(0xff0b959e),
    primaryColorDark: Color(0xff464594),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff464594),
    primaryColor: Colors.white,
    buttonColor: Color(0xff464594),
  );
}
