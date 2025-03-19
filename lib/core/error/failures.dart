import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}


class RepeatedPhoneNumberFailure extends Failure {
  @override
  List<Object?> get props => [];
}
class RepeatedEmailFailure extends Failure {
  @override
  List<Object?> get props => [];
}


class NoFoundedUserFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}






class ServerTimeOutExceptionFailure extends Failure {
  @override
  List<Object?> get props => [];
}


class NotCorrectCredentialsFailure extends Failure {
  @override
  List<Object?> get props => [];
}




class PhoneNumberNotCorrectFailure extends Failure {
  @override
  List<Object?> get props => [];
}


class BadRequestFailure extends Failure {
  @override
  List<Object?> get props => [];
}




class ApiErrorModel extends Failure{

  late int statusCode;
  List<String> errors;
  late String message;

  ApiErrorModel({
    required this.statusCode,
    this.errors = const [],
    required this.message
  });

  // Factorizing Response
  factory ApiErrorModel.fromJson(Map<String,dynamic>json){
    List<String> errs = [];
    if(json['error'] != null){
      if(json['error'].isNotEmpty){
        json['error'].forEach((element){
          errs.add(element);
        });
      }
    }
    return ApiErrorModel(
      message: json['message'],
      statusCode: json['status'],
      errors: errs,
    );
  }

  @override
  List<Object?> get props => [message,errors,statusCode];

}