import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';
import '../entities/register_request_body.dart';

abstract class RegisterRepository
{
  Future<Either<Failure,User?>> registerToApp(RegisterRequestBody requestBody);
}