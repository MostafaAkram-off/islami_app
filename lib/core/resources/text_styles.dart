import 'package:flutter/material.dart';
import 'package:islami_app/core/resources/colors_manger.dart';

class TextStyles {
  static TextStyle largeTitleTextStyle({
    Color textColor = ColorsManger.goldColor,
  }) {
    return TextStyle(
      color: ColorsManger.goldColor,
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
}
