import 'dart:io';

 import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

 import '../../../../core/shared-widgets/spacing.dart';
import '../../../../core/styles/colors/app_colors.dart';
 import '../../../../core/styles/text_styles/app_text_styles.dart';
import '../widgets/registration_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.homeBackgroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.homeBackgroundColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: (){
              context.pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          physics:   BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical:   4.h,
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                   "Registration",
                    style: TextStyles.font32BlueBold(context),
                  ),
                  const RegistrationForm(),

                  verticalSpace(10),
                 /* const SignInTextWidget(),*/  //zead comment
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
