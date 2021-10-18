
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkTheme=ThemeData(
    primarySwatch: deafultColor,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('333739'),
            statusBarIconBrightness: Brightness.light
        ),
        backgroundColor: HexColor('333739'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
            color:Colors. white
        )

    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepPurple
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor:deafultColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: HexColor('333739')
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.white
        ),
      caption: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.white
      ),
      subtitle1: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          color: Colors.white
      ),
    )
);

ThemeData lightTheme=ThemeData(
    primarySwatch: deafultColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
            color:Colors. black
        )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor:deafultColor
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor:deafultColor,
        backgroundColor: Colors.white
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),
      caption: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          color: Colors.black
      ),
      subtitle1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        height: 1.3,
      ),
    )

);

// TextTheme textTheme=TextTheme(
//   bodyText1: TextStyle(
//       fontSize: 18.0,
//       fontWeight: FontWeight.w600,
//       color: Colors.white
//   ),
//   caption: TextStyle(
//       fontSize: 16.0,
//       fontWeight: FontWeight.w600,
//       color: Colors.white
//   ),
//   subtitle1: TextStyle(
//     fontSize: 10.0,
//     fontWeight: FontWeight.w600,
//     color: Colors.white
// ),
// );