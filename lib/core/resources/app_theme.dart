import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/colors_manger.dart';
import 'package:islami_app/core/resources/text_styles.dart';

abstract class AppTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    fontFamily: "Janna",
    scaffoldBackgroundColor: ColorsManger.blackColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsManger.goldColor,
      brightness: Brightness.dark,
      primary: ColorsManger.goldColor,
      surface: ColorsManger.blackColor,
    ),
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      iconTheme: const IconThemeData(color: ColorsManger.goldColor),
      titleTextStyle: TextStyles.smallTitleTextStyle(),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ColorsManger.goldColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManger.goldColor,
        foregroundColor: ColorsManger.blackColor,
      ),
    ),
  );
}
