import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/login_request_body.dart';
import '../entities/login_response_body.dart';

abstract class LoginRepository{

  Future<Either<Failure,LoginResponseBody>> loginWithEmailAndPassword(LoginRequestBody body);

}