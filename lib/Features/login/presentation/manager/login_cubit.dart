import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/login_request_body.dart';
import '../../domain/entities/login_response_body.dart';
import '../../domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginWithEmailAndPassword useCase;


  LoginCubit({required this.useCase}) : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void loginWithEmailAndPassword() async {
    final requestBody = LoginRequestBody(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    emit(LoginLoading());
    final response = await useCase.execute(requestBody);

    emit(_mapFailureOrUserDataToState(response));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Server faliure Try Again";

      case OfflineFailure:
        return "Your Internet is disconnected";

      case NotCorrectCredentialsFailure:
        return "Email or Password is incorrect";
      case NotVerifiedFailure:
        return "Please verfie your Email First through the link";


      default:
        return "Try Again";
    }
  }

  LoginState _mapFailureOrUserDataToState(
      Either<Failure, LoginResponseBody> either) {
    return either.fold(
          (failure) {
        return LoginErrorState(_mapFailureToMessage(failure));
      },
          (response) {
        return UserDataLoaded(response);
      },
    );
  }
}
