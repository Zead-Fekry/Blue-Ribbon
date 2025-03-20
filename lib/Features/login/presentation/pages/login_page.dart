import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/routing/routes.dart';
import '../../../signup/presentation/pages/register_page.dart';
import '../../../signup/presentation/pages/signupWithGoogle.dart';
import '../widgets/login_form.dart';
import '../../../../core/shared-widgets/spacing.dart';
import '../../../../core/styles/text_styles/app_text_styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  void _handleGoogleSignIn(BuildContext context) async {
    final authService = AuthService();
    User? user = await authService.signInWithGoogle();

    if (user != null) {
      List<String>? interests;
        String uid = user.uid;

        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection("UserInterests")
            .doc(uid)
            .get();

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          interests = List<String>.from(data['interests'] ?? []);
        }

       Navigator.pushReplacementNamed(
        context,
        Routes.NewsScreen,arguments: {
        "interests": interests ?? ["Apple"],
        "userId": user.uid,
      },

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 15.0),
                Stack(
                  children: [
                    Center(
                      child: Text(
                        "Login",
                        style: TextStyles.font32BlueBold(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: LoginForm(),
                ),
              ],
            ),
          ),
          verticalSpace(10),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const RegisterPage()),
              );
            },
            child: Text(
              "Registration",
              style: TextStyles.font14BlueSemiBold(context),
            ),
          ),
          verticalSpace(10),

          // Google Sign-In Button
          GestureDetector(
            onTap: () => _handleGoogleSignIn(context),
            child: Image.asset(
              "assets/google_logo.png",
              width: 50, // Adjust size as needed
            ),
          ),

        ],
      ),
    );
  }
}
