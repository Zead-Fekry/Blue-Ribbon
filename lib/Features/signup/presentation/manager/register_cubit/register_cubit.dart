import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
 import '../../../domain/entities/register_request_body.dart';
import '../../../domain/use_cases/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit({required this.registerUseCase}) : super(RegisterInitial());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  final formKey = GlobalKey<FormState>();

  void registerMethod(RegisterRequestBody requestBody) async{
    emit(RegisterLoading());
    final response = await registerUseCase.execute(requestBody);
    emit(_mapFailureOrUserDataToState(response));
  }

  RegisterState _mapFailureOrUserDataToState(Either<Failure,User?> either) {
    return either.fold(
          (failure) {
        return RegisterError(_mapFailureToMessage(failure));
      },
          (_) {
        return LoadedUserData(message: "registration successful");
      },
    );
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Server faliure Try Again";
      case OfflineFailure:
        return "Your Internet is disconnected";
      case RepeatedEmailFailure:
        return "Repeated Email Address";
      default:
        return"Try Again";
    }
  }

}
