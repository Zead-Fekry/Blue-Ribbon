import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginResponseBody extends Equatable{
   late List<String> Intersets;
late String? UserId;

  LoginResponseBody({
      required this.Intersets,
    required this.UserId,

  });

  @override
  List<Object?> get props => [Intersets,UserId ];


}
