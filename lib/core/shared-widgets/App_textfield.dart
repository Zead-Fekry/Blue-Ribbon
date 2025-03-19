import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors/app_colors.dart';
 import '../styles/text_styles/app_text_styles.dart';

class AppTextFormField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool isPassword;
  final bool isEnabled;
  final void Function(String)? fn;
  const AppTextFormField({
    Key? key,
    required this.title,
    required this.controller,
    required this.validator,
    this.isPassword = false,
    this.isEnabled = true,
    this.fn,
  }) : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool isSecure = false;
  @override
  void initState() {
    super.initState();
    isSecure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.symmetric(
        vertical: 2.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style:TextStyles.font6BlackRegular(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
            SizedBox(
            height: 1.h,
          ),
          TextFormField(
            controller: widget.controller,
            obscureText: isSecure,
            enabled: widget.isEnabled,
            onFieldSubmitted: widget.fn,
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.lighterGray,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0.sp),
                    borderSide: BorderSide.none),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0.sp),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0.sp),
                    borderSide: BorderSide.none),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0.sp),
                    borderSide: BorderSide.none),
                suffixIcon: widget.isPassword
                    ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSecure = !isSecure;
                    });
                  },
                  icon: Icon(
                    isSecure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.black,
                  ),
                )
                    : null),
            cursorColor: AppColors.mainBlue,
            style: TextStyles.font6BlackRegular(context)
                 ,
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}
