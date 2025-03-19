import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'Features/news/presentation/manager/news_cubit.dart';
import 'Features/signup/presentation/manager/register_cubit/register_cubit.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/styles/colors/app_colors.dart';
import 'injection_container.dart' as di;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<RegisterCubit>()),
        BlocProvider(create: (_) => di.sl<NewsCubit>()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            theme: ThemeData(
              primaryColor: AppColors.mainBlue,
              scaffoldBackgroundColor: Colors.white,
              useMaterial3: false,
            ),
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            initialRoute: Routes.splashScreen,
            // Optional: Hides the debug banner
            onGenerateRoute: widget.appRouter.generateRoute, // Use your router
          );
        },
      ),
    );
  }
}
