import 'package:equatable/equatable.dart';

class RegisterRequestBody extends Equatable{

  late String name;
  late String email;
  late String password;


  RegisterRequestBody({
    required this.email,
    required this.password,
    required this.name,


  });

  @override
  List<Object?> get props => [name,email,password ];


}