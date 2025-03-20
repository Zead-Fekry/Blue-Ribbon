import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/networking/network_info.dart';
 import '../../domain/entities/login_request_body.dart';
import '../../domain/entities/login_response_body.dart';
import '../../domain/repositories/login_repository.dart';
import '../data_sources/remote_data_source.dart';
import '../models/login_request_body_model.dart';

class LoginRepositoryImp implements LoginRepository{


  final LoginRemoteDataSource remoteDataSource;
   final NetworkInfo networkInfo;

  LoginRepositoryImp({
    required this.remoteDataSource,
    required this.networkInfo,
   });


  @override
  Future<Either<Failure, LoginResponseBody>> loginWithEmailAndPassword(LoginRequestBody body)async{
    if(await networkInfo.isConnected) {
      try {
        LoginRequestBodyModel requestBodyModel = LoginRequestBodyModel(
          email: body.email,
          password: body.password,
        );

        final responseBody = await remoteDataSource.login(requestBodyModel);

        return Right(responseBody);
      } catch(error)
      {

        if(error is NotVerifiedException){
          return Left(NotVerifiedFailure());
        }
        else if(error is NotCorrectCredentials){
          return Left(NotCorrectCredentialsFailure());
        }

        else{
          return Left(ServerFailure());
        }
      }
    }
    else{
      return Left(OfflineFailure());
    }
  }

}