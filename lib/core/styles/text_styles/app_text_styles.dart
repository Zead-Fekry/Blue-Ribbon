import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../colors/app_colors.dart';
import '../font_wieght_helper/font_wieght_helper.dart';

class TextStyles {
  static const String fontName = 'Cairo';

  static TextStyle font6WhiteMedium(context) {
    return TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeightHelper.medium,
      color: Colors.white,
      fontFamily: fontName,
    );
  }

  static TextStyle font32BlueBold(context) {
    return TextStyle(
      fontSize: 30.sp,
      fontWeight: FontWeightHelper.bold,
      color: AppColors.mainBlue,
      fontFamily: fontName,
    );
  }

  static TextStyle font13BlueSemiBold(context) {
    return TextStyle(
      fontSize: 13,
      fontWeight: FontWeightHelper.semiBold,
      color: AppColors.mainBlue,
      fontFamily: fontName,
    );
  }

  static TextStyle font6BlueSemiBold(context) {
    return TextStyle(
      fontSize: 6,
      fontWeight: FontWeightHelper.semiBold,
      color: AppColors.mainBlue,
      fontFamily: fontName,
    );
  }

  static TextStyle font14BlueSemiBold(context) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeightHelper.semiBold,
      color: AppColors.mainBlue,
      fontFamily: fontName,
    );
  }

  static TextStyle font16BlackMedium(context) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeightHelper.medium,
      color: Colors.black,
      fontFamily: fontName,
    );
  }

  static TextStyle font6BlackRegular(context) {
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeightHelper.regular,
      color: Colors.black,
      fontFamily: fontName,
    );
  }
}
