import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors/app_colors.dart';
 import '../styles/text_styles/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final VoidCallback fn;
  final String text;
  final TextStyle? btnStyle;
  final bool isMain;

  const AppButton({
    Key? key,
    required this.fn,
    required this.text,
    this.btnStyle,
    this.isMain = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fn,
      borderRadius: BorderRadius.circular(25.0.sp),
      child: Container(
        height:  5.h,
        decoration: BoxDecoration(
          color: isMain ? AppColors.mainBlue : AppColors.lightGray,
          borderRadius: BorderRadius.circular(12.0.sp),
          gradient: LinearGradient(
            colors: [
              isMain ? AppColors.mainBlue.withOpacity(0.6) : AppColors.lightGray.withOpacity(0.6) ,
              isMain ? AppColors.mainBlue.withOpacity(0.8) : AppColors.lightGray.withOpacity(0.8) ,
              isMain ? AppColors.mainBlue.withOpacity(1) : AppColors.lightGray.withOpacity(1) ,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: (btnStyle == null)?((isMain)
                ?   TextStyles.font6WhiteMedium(context)

                :   TextStyles.font6BlackRegular(context)
               ):btnStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
