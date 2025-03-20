import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/shared-widgets/app_button.dart';
import '../../../../core/shared-widgets/loading_widget.dart';
import '../../../../core/shared-widgets/snack_bar_manager.dart';
import '../../../../injection_container.dart' as di;
import '../manager/login_cubit.dart';

class LoginButtonConsumer extends StatelessWidget {
  const LoginButtonConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is UserDataLoaded) {
          Navigator.pushNamed(
            context,
            Routes.NewsScreen,arguments: {
            "interests": state.userIntersets.Intersets,
            "userId": state.userIntersets.UserId,
          },
          );
        } else if (state is LoginErrorState) {
          SnackBarMessage().showErrorSnackBar(
            message: state.message,
            context: context,
          );

          if (state.message == "Please verify your email first through the link") {
            SnackBarMessage().showErrorSnackBar(
              message: state.message,
              context: context,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        if (state is LoginLoading) {
          return const LoadingWidget();
        }

        return SizedBox(
          width: double.infinity,
          child: AppButton(
            fn: () {
              if (context.read<LoginCubit>().formKey.currentState!.validate()) {
                cubit.loginWithEmailAndPassword();
              }
            },
            text: "Login",
          ),
        );
      },
    );
  }
}
