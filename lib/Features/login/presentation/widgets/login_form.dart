 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 import '../../../../core/shared-widgets/App_textfield.dart';
import '../../../../core/shared-widgets/spacing.dart';
import '../../../../core/utlis/app_regx.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {

   return SizedBox();
  }


 /* @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(10),
          AppTextFormField(
            validator: (value){
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                  'Please enter a valid email' ;
              }
              return null;
            },
            controller: context.watch<LoginCubit>().emailController,
            title: LocaleKeys.email_txt.tr(),
            fn: (p0) {
              if(LoginCubit.get(context).formKey.currentState!.validate()) {
                LoginCubit.get(context).loginWithEmailAndPassword();
              }
            },
          ),
          verticalSpace(10),

          AppTextFormField(
            validator: (value){
              if(value==null||value.isEmpty){
                'Password cannot be empty' ;
              }
              return null;
            },
            controller: context.watch<LoginCubit>().passwordController,
            title: LocaleKeys.password_txt.tr(),
            isPassword: true,
            fn: (p0) {
              if(LoginCubit.get(context).formKey.currentState!.validate()) {
                LoginCubit.get(context).loginWithEmailAndPassword();
              }
            },
          ),
          verticalSpace(24),
          const LoginButtonConsumer(),
        ],
      ),
    );
  }*/
}
