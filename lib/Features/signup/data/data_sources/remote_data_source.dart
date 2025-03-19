import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/exception.dart';
import '../models/RegisterRequestBodyModel.dart';

abstract class RegisterRemoteDataSource {
  Future<User?> register(RegisterRequestBodyModel request);
}

class RegisterRemoteDataSourceImpWithDio implements RegisterRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User?> register(RegisterRequestBodyModel request) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      return userCredential.user; // Always return, even if it's null
    } on FirebaseAuthException catch (e) {
      if(e.code=="email-already-in-use") {
        throw RepeatedEmailException();
      }// Handle errors gracefully
    } on SocketException {
      throw OfflineException();

    } catch (e) {
      throw ServerException();
    }
  }
}
