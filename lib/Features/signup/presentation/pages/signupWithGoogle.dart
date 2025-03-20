import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/routing/routes.dart';
import '../../../../main.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;


      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

       final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;


      if (userCredential.additionalUserInfo!.isNewUser&&navigatorKey.currentContext != null) {
        Navigator.pushReplacementNamed( navigatorKey.currentContext!, Routes.InterstSelection,arguments:userCredential.user);

      }

      return user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

   Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
