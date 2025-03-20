import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routing/routes.dart';
import '../styles/colors/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateTo();


  }

  void navigateTo() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {  // Ensures widget is still in the tree before navigating
      Navigator.pushReplacementNamed(context, Routes.loginScreen); // goNamed instead of pushReplacementNamed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient Background
          AnimateGradient(
            primaryColors: [
              AppColors.mainBlue,
              AppColors.mainBlue.withOpacity(0.8),
              AppColors.mainBlue.withOpacity(0.6),
            ],
            secondaryColors: [
              AppColors.mainPurple,
              AppColors.mainPurple.withOpacity(0.8),
              AppColors.mainPurple.withOpacity(0.6),
            ],
            child: Container(),
          ),

          // Logo Image (Centered)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/ribbon.jpeg',
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
