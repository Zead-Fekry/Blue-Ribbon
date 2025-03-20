import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NotVerifiedFailure extends Failure {
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

class NotCorrectCredentialsFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class BadRequestFailure extends Failure {
  @override
  List<Object?> get props => [];
}
