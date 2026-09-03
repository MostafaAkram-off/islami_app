import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/colors_manger.dart';

class TextStyles {
  static TextStyle largeTitleTextStyle({
    Color textColor = ColorsManger.goldColor,
  }) {
    return TextStyle(
      color: textColor,
      fontWeight: FontWeight.w900,
      fontSize: 24,
      fontFamily: "Janna",
    );
  }

  static TextStyle mediumTitleTextStyle({
    Color textColor = ColorsManger.goldColor,
  }) {
    return TextStyle(
      color: textColor,
      fontWeight: FontWeight.w900,
      fontSize: 22,
      fontFamily: "Janna",
    );
  }

  static TextStyle smallTitleTextStyle({
    Color textColor = ColorsManger.goldColor,
  }) {
    return TextStyle(
      color: textColor,
      fontWeight: FontWeight.w900,
      fontSize: 20,
      fontFamily: "Janna",
    );
  }

  static TextStyle largeLabelTextStyle({
    Color textColor = ColorsManger.goldColor,
  }) {
    return TextStyle(
      color: textColor,
      fontWeight: FontWeight.w900,
      fontSize: 22,
      fontFamily: "Janna",
    );
  }

  static TextStyle mediumLabelTextStyle({
    Color textColor = ColorsManger.goldColor,
  }) {
    return TextStyle(
      color: textColor,
      fontWeight: FontWeight.w900,
      fontSize: 20,
      fontFamily: "Janna",
    );
  }

  static TextStyle smallLabelTextStyle({
    Color textColor = ColorsManger.goldColor,
  }) {
    return TextStyle(
      color: textColor,
      fontWeight: FontWeight.w900,
      fontSize: 18,
      fontFamily: "Janna",
    );
  }

  static TextStyle largeBodyTextStyle({
    Color textColor = ColorsManger.whiteColor,
  }) {
    return TextStyle(
      color: textColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      fontFamily: "Janna",
    );
  }

  static TextStyle mediumBodyTextStyle({
    Color textColor = ColorsManger.whiteColor,
  }) {
    return TextStyle(
      color: textColor,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      fontFamily: "Janna",
    );
  }

  static TextStyle smallBodyTextStyle({
    Color textColor = ColorsManger.whiteColor,
  }) {
    return TextStyle(
      color: textColor,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      fontFamily: "Janna",
    );
  }

  /// ستايل نص السور والأحاديث في شاشات التفاصيل.
  /// الوزن w700 بيوصل لخط Janna Regular، وw900 هو اللي بيوصل للـ Bold
  static TextStyle suraVerseTextStyle({
    Color textColor = ColorsManger.goldColor,
  }) {
    return TextStyle(
      color: textColor,
      fontWeight: FontWeight.w700,
      fontSize: 16,
      height: 2.1,
      fontFamily: "Janna",
    );
  }

  /// نص الحديث جوه الكارت في التاب — Regular وصغير زي الديزاين
  static TextStyle hadethCardTextStyle({
    Color textColor = ColorsManger.blackColor,
  }) {
    return TextStyle(
      color: textColor,
      fontWeight: FontWeight.w700,
      fontSize: 14,
      height: 1.75,
      fontFamily: "Janna",
    );
  }
}
