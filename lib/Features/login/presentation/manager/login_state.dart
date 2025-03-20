part of 'login_cubit.dart';

@immutable
sealed class LoginState extends Equatable
{

}

final class LoginInitial extends LoginState
{
  @override
  List<Object?> get props => [];
}
class LoginLoading extends LoginState{
  @override
  List<Object?> get props => [];

}
class UserDataLoaded extends LoginState{

  final LoginResponseBody userIntersets;
  UserDataLoaded(this.userIntersets);
  @override
  List<Object?> get props => [userIntersets];

}
class LoginErrorState extends LoginState{

  final String message;

  LoginErrorState(this.message);
  @override
  List<Object?> get props => [message];
}