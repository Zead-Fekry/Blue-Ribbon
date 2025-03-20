import 'package:app_links/app_links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_letter_app/Features/login/presentation/manager/login_cubit.dart';
import 'package:sizer/sizer.dart';

 import 'Features/news/presentation/manager/news_cubit.dart';
import 'Features/news/presentation/screens/News.dart';
import 'Features/signup/presentation/manager/register_cubit/register_cubit.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/styles/colors/app_colors.dart';
import 'injection_container.dart' as di;

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;

  const MyApp({
    super.key,
    required this.appRouter,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _handleDeepLinks();
  }

  Future<void> _handleDeepLinks() async {
    _appLinks.uriLinkStream.listen((Uri? uri) async {
      if (uri != null) {
         String? uid = uri.queryParameters["uid"];
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection("UserInterests")
            .doc(uid)
            .get();
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

          List<String> interests = List<String>.from(data['interests'] ?? []);
          Navigator.push(
              navigatorKey.currentContext!,
              MaterialPageRoute(
                  builder: (context) => NewsScreen(
                    interests: interests,
                    UserId:uid ,
                      )));

        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<RegisterCubit>()),
        BlocProvider(create: (_) => di.sl<LoginCubit>()),
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
            onGenerateRoute: widget.appRouter.generateRoute,
          );
        },
      ),
    );
  }
}
