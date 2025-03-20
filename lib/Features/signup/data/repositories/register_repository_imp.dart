import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/networking/network_info.dart';
import '../../domain/entities/register_request_body.dart';
import '../../domain/repositories/register_repository.dart';
import '../data_sources/remote_data_source.dart';
import '../models/RegisterRequestBodyModel.dart';

class RegisterRepositoryImpl implements RegisterRepository{

  final RegisterRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RegisterRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });



  @override
  Future<Either<Failure, User?>> registerToApp(RegisterRequestBody requestBody) async{

    if(await networkInfo.isConnected) {
      try {
        RegisterRequestBodyModel requestBodyModel = RegisterRequestBodyModel(
          email: requestBody.email,
          password: requestBody.password,
          name: requestBody.name,
        );

        final responseBody = await remoteDataSource.register(requestBodyModel);
        return Right(responseBody);
      } catch(error) {
        if(error is RepeatedEmailException){
          return Left(RepeatedEmailFailure());

        }

        else {
          return Left(ServerFailure());
        }
      }
    }
    else{
      return Left(OfflineFailure());
    }
  }


}