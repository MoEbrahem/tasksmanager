import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasksmanager/AppColor.dart';

ThemeData LightTheme = ThemeData(
  scaffoldBackgroundColor: AppColor.backgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColor.primaryLightColor,
    titleSpacing: 35,

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    
    selectedItemColor: AppColor.primaryLightColor,
    unselectedItemColor: AppColor.unselectIconColor,
    elevation: 0,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    backgroundColor: Colors.transparent,
    selectedLabelStyle: GoogleFonts.poppins(
      fontSize: 12
    )
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    padding: EdgeInsets.symmetric(horizontal: 5),
    shape: CircularNotchedRectangle(),
    color: AppColor.whiteColor,
    height: 70,
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
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColor.whiteColor,
    ),

    // cart title - bottomSheet title - time in BottomSheet

    titleMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryLightColor,
    ),

    // calender nameDays

    titleSmall: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColor.textColor,
    ),

    // Digital Time

    bodySmall: GoogleFonts.roboto(
      fontSize: 10,
      color: AppColor.textColor,
    ),

    // hint TextStyle - selectTime

    bodyMedium: GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColor.hintText,
    ),
    // title Lang - Mode
    headlineSmall: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppColor.textColor,
    ),
  ),
);


ThemeData DarkTheme = ThemeData(
  scaffoldBackgroundColor: AppColor.darkBackgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColor.primaryLightColor,
    titleSpacing: 35,

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    
    selectedItemColor: AppColor.primaryLightColor,
    unselectedItemColor: AppColor.unselectIconColor,
    elevation: 0,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    backgroundColor: Colors.transparent,
    selectedLabelStyle: GoogleFonts.poppins(
      fontSize: 12
    )
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    padding: EdgeInsets.symmetric(horizontal: 5),
    shape: CircularNotchedRectangle(),
    color: AppColor.darkBackgroundColor,
    height: 70,
    elevation: 0,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColor.darkBackgroundColor,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    elevation: 4,
    backgroundColor: AppColor.primaryLightColor,
    shape: RoundedRectangleBorder(
      
      borderRadius: BorderRadius.circular(35),
      side: const BorderSide(
        color: AppColor.darkBackgroundColor,
        width: 5,
      ),
    ),
  ),
  textTheme: TextTheme(
    ///  appBar - done in cart

    titleLarge: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColor.whiteColor,
    ),

    // cart title - bottomSheet title - time in BottomSheet

    titleMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColor.primaryLightColor,
    ),

    // calender nameDays

    titleSmall: GoogleFonts.roboto(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: AppColor.whiteColor,
    ),

    // Digital Time

    bodySmall: GoogleFonts.roboto(
      fontSize: 10,
      color: AppColor.whiteColor,
    ),

    // hint TextStyle - selectTime

    bodyMedium: GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColor.hintText,
    ),
    // title Lang - Mode
    headlineSmall: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppColor.whiteColor,
    ),


    
  ),
);
