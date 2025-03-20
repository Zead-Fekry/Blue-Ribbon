part of 'register_cubit.dart';

@immutable
sealed class RegisterState extends Equatable
{
  @override
  List<Object?> get props => [];
}

final class RegisterInitial extends RegisterState
{

}

class RegisterLoading extends RegisterState{
  @override
  List<Object?> get props => [];
}

class LoadedUserData extends RegisterState{
  final String message;
  LoadedUserData({required this.message});

  @override
  List<Object?> get props => [message];
}

class RegisterError extends RegisterState{

  final String message;

  RegisterError(this.message);

  @override
  List<Object?> get props => [message];
}