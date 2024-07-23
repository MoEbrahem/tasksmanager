import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasksmanager/AppColor.dart';

ThemeData LightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColor.primaryLightColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColor.primaryLightColor,
    unselectedItemColor: AppColor.unselectIconColor,
    elevation: 0,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    backgroundColor: Colors.transparent,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    shape: CircularNotchedRectangle(),
    color: AppColor.whiteColor,
    elevation: 0,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColor.whiteColor,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.primaryLightColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
      side: const BorderSide(
        color: AppColor.whiteColor,
        width: 5,
      ),
    ),
  ),
  textTheme: TextTheme(
    ///  appBar - done in cart

    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColor.whiteColor,
    ),

    // cart title - bottomSheet title - time in BottomSheet

    titleMedium: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryLightColor,
    ),

    // calender nameDays

    titleSmall: GoogleFonts.roboto(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: AppColor.textColor,
    ),

    // Digital Time

    bodySmall: GoogleFonts.roboto(
      fontSize: 12,
      color: AppColor.textColor,
    ),

    // hint TextStyle - selectTime

    bodyMedium: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColor.hintText,
    ),
  ),
);
