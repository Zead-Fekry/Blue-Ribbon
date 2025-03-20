import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/exception.dart';
import '../models/login_request_body_model.dart';
import '../models/login_response_body_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponseBodyModel> login(LoginRequestBodyModel request);
}

class LoginRemoteDataSourceImpWithFirebase implements LoginRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<LoginResponseBodyModel> login(LoginRequestBodyModel request) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      User? user = userCredential.user;
      if (user != null) {
        String uid = user.uid;

        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection("UserInterests")
            .doc(uid)
            .get();

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          List<String> interests = List<String>.from(data['interests'] ?? []);

          return LoginResponseBodyModel(  Intersets: interests,UserId:uid );
        } else {

          throw  NotVerifiedException();
        }
      } else {
        throw ServerException();
      }
    } on FirebaseAuthException catch (e) {
      if(e.code=="invalid-credential"){
      throw  NotCorrectCredentials();}
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
