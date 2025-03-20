import 'package:equatable/equatable.dart';

class LoginRequestBody extends Equatable{

  late String email;
  late String password;

  LoginRequestBody({
    required this.email,
    required this.password,
     });

  @override
  List<Object?> get props => [email,password];
}