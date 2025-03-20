import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/login_request_body.dart';
import '../entities/login_response_body.dart';
import '../repositories/login_repository.dart';

class LoginWithEmailAndPassword{

  final LoginRepository loginRepository;
  LoginWithEmailAndPassword({required this.loginRepository});

  Future<Either<Failure,LoginResponseBody>> execute(LoginRequestBody body){
    return loginRepository.loginWithEmailAndPassword(body);
  }

}