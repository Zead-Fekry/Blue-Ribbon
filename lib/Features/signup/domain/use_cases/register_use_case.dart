import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';
import '../entities/register_request_body.dart';
import '../repositories/register_repository.dart';

class RegisterUseCase{

  final RegisterRepository repository;
  RegisterUseCase({required  this.repository});


  Future<Either<Failure,User?>> execute(RegisterRequestBody requestBody) async{
    return repository.registerToApp(requestBody);
  }

}