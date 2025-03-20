import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_letter_app/core/routing/routes.dart';
import '../../../../core/error/exception.dart';
import '../../../../main.dart';
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
      if (userCredential.user != null) {
        // Navigate to Interest Selection Screen
        if (navigatorKey.currentContext != null) {
          Navigator.pushReplacementNamed(navigatorKey.currentContext!, Routes.InterstSelection,arguments:userCredential.user);
        }      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if(e.code=="email-already-in-use") {
        throw RepeatedEmailException();
      }
      else if(e.code=="network-request-failed"){
      throw ServerException();}
    } on SocketException {
      throw OfflineException();

    } catch (e) {
      throw ServerException();
    }

  }

}
