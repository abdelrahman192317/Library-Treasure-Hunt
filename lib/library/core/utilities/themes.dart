import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    canvasColor: canvas,
    focusColor: primary.withOpacity(0.1),
    dividerColor: const Color(0xffBBBBBB),
    hintColor: Colors.white,
    splashColor: Colors.white,
    colorScheme: ColorScheme.light(
      background: background,
      primary: primary,
      secondary: canvas,
      shadow: Colors.black,
      error: Colors.red,
    ),
    textTheme: TextTheme(
      headlineMedium: AppTextStyles.headlineMedium,
      titleLarge: GoogleFonts.harmattan(
          textStyle: const TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700)),
      titleMedium: GoogleFonts.harmattan(
          textStyle: const TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600)),
      titleSmall: GoogleFonts.harmattan(
          textStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      bodyLarge: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.black)),
      bodyMedium: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.black87)),
      bodySmall: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.black54)),
      labelLarge: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.black)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
      shadowColor: primary,
      backgroundColor: primary,
      textStyle:
          GoogleFonts.roboto(textStyle: const TextStyle(color: Colors.white)),
    )),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 1,
      shadowColor: Colors.black,
      color: canvas,
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      backgroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: background,
    disabledColor: const Color(0xff909090),
    shadowColor: Colors.black54,
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primary,
    canvasColor: canvas,
    focusColor: primary.withOpacity(0.1),
    dividerColor: const Color(0xffBBBBBB),
    hintColor: const Color(0xff35383F),
    splashColor: const Color(0xff181A20),
    colorScheme: ColorScheme.dark(
      background: const Color(0xff181A20),
      primary: primary,
      secondary: canvas,
      shadow: Colors.white60,
      error: Colors.red,
    ),
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.white)),
      titleLarge: GoogleFonts.harmattan(
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
      titleMedium: GoogleFonts.harmattan(
          textStyle: const TextStyle(
              color: Colors.white70,
              fontSize: 22,
              fontWeight: FontWeight.w600)),
      titleSmall: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.white60)),
      bodyLarge: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.white)),
      bodyMedium: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.white70)),
      bodySmall: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.white60)),
      labelLarge: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.white)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
      shadowColor: primary,
      backgroundColor: primary,
      textStyle: GoogleFonts.harmattan(
          textStyle: const TextStyle(color: Colors.white)),
    )),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 1,
      shadowColor: Colors.white60,
      color: canvas,
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      backgroundColor: const Color(0xff35383F),
    ),
    scaffoldBackgroundColor: background,
    disabledColor: const Color(0xff828282),
    shadowColor: Colors.white70,
  );
}
