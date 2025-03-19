import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_letter_app/core/routing/routes.dart';

import '../../Features/login/presentation/pages/login.dart';
 import '../../Features/signup/presentation/pages/register_page.dart';
import '../../Features/signup/presentation/widgets/Interest_Selection.dart';
import '../shared-widgets/splash.dart';

class AppRouter
{
Route generateRoute(RouteSettings settings)
{
  final arguments = settings.arguments;
  switch (settings.name)
  {
    case "/":
      return MaterialPageRoute(
        builder: (context) => const Scaffold(),
      );
    case Routes.loginScreen:
      return MaterialPageRoute(
        builder: (context) => const Login(),
      );
    case Routes.splashScreen:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );

    case Routes.signUpScreen:
      return MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      );
    case Routes.InterstSelection:
      return MaterialPageRoute(
        builder: (context) => InterestSelectionScreen(user: arguments as User,),
      );
    default:
      SystemNavigator.pop();
      return MaterialPageRoute(

        builder: (_) => const Scaffold(),
      );
  }
}


}