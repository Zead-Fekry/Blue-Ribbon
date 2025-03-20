import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

 import '../../../../core/shared-widgets/App_textfield.dart';
import '../../../../core/shared-widgets/app_button.dart';
import '../../../../core/shared-widgets/loading_widget.dart';
import '../../../../core/shared-widgets/password_field.dart';
import '../../../../core/shared-widgets/snack_bar_manager.dart';
import '../../../../core/shared-widgets/spacing.dart';
import '../../../../core/utlis/app_regx.dart';
import '../../domain/entities/register_request_body.dart';
import '../manager/register_cubit/register_cubit.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _codeController.dispose();
    _mobileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<RegisterCubit>().formKey,
      child: Center(
        child: SizedBox(
          width: double.infinity,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppTextFormField(
                title:"Email",
                controller: _emailController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isEmailValid(value)) {
                    return 'Please enter a valid email';
                  }
                  if (value.contains(" ")) {
                    return  'Email Cannot contain spaces'
                      ;
                  }
                  return null;
                },
              ),

              Sample2(
                title:"password",
                controller: _passwordController,
                isPassword: false,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return   'Password cannot be empty'
                         ;
                  } else if (!AppRegex.hasNumber(value)) {
                    return   'Password must contain at least 1 number'
                          ;
                  } else if (!AppRegex.hasLowerCase(value)) {
                    return  'Password must contain at least 1 lower character'
                       ;
                  } else if (!AppRegex.hasSpecialCharacter(value)) {
                    return   'Password must contain at least 1 special character(&,\$,#,..)'
                         ;
                  } else if (!AppRegex.hasUpperCase(value)) {
                    return   'Password must contain at least 1 Upper character'
                       ;
                  } else if (!AppRegex.hasMinLength(value)) {
                    return   'Password length must be at least 8'
                      ;
                  } else {
                    return null;
                  }
                },
              ),

              AppTextFormField(
                title: "Username",
                controller: _usernameController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      AppRegex.hasNumber(value)) {
                    return   'Name Cannot contain numbers'
                         ;
                  }
                  if (value.contains(" ")) {
                    return   'Name Cannot contain spaces'
                      ;
                  }
                  return null;
                },
              ),

              verticalSpace(5.h),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterError) {
                    SnackBarMessage().showErrorSnackBar(
                      message: state.message.trim(),
                      context: context,
                    );
                  } else if (state is LoadedUserData) {
                    SnackBarMessage().showSuccessSnackBar(
                      message: state.message.trim(),
                      context: context,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const LoadingWidget();
                  }
                  var cubit = RegisterCubit.get(context);
                  return AppButton(
                    fn: () {
                      if (context
                          .read<RegisterCubit>()
                          .formKey
                          .currentState!
                          .validate()) {
                        RegisterRequestBody body = RegisterRequestBody(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          name: _usernameController.text.trim(),

                        );
                        cubit.registerMethod(body);
                      }
                    },
                    text: "Registration",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
