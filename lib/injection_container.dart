 import 'package:get_it/get_it.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Features/news/data/data_sources/remote_data_source.dart';
import 'Features/news/data/repositories/NewRepository_impl.dart';
import 'Features/news/domain/repositories/News_repository.dart';
import 'Features/news/domain/use_cases/getAllNews.dart';
import 'Features/news/presentation/manager/news_cubit.dart';
import 'Features/signup/data/data_sources/remote_data_source.dart';
import 'Features/signup/data/repositories/register_repository_imp.dart';
import 'Features/signup/domain/repositories/register_repository.dart';
import 'Features/signup/domain/use_cases/register_use_case.dart';
import 'Features/signup/presentation/manager/register_cubit/register_cubit.dart';
import 'core/networking/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {



//-----------------CubitsInjection---------------------//
  sl.registerFactory(() => RegisterCubit(registerUseCase: sl()));
  /*  sl.registerFactory(() => LoginCubit(useCase: sl()));*/
  sl.registerFactory(() => NewsCubit(getAllNews: sl()));





//-------------------UsecasesInjection------------------//
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllNews(repository: sl()));









  //--------------------------repositoriesInjection-------------------//
  /*  sl.registerLazySingleton(
          () => LoginWithEmailAndPassword(loginRepository: sl()));*/

  sl.registerLazySingleton<RegisterRepository>(
        () => RegisterRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );


  sl.registerLazySingleton<NewsRepository>(
        () => NewsRepositoryImpl(
       newsRemoteDatasource: sl(),
    ),
  );





  //------------------------------------DataSourcesInjection---------------------//
  sl.registerLazySingleton<RegisterRemoteDataSource>(
          () => RegisterRemoteDataSourceImpWithDio());
  sl.registerLazySingleton<NewsRemoteDatasource>(
          () => NewsRemoteImplWithDio());
/*
  sl.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImp(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localDataSource: sl(),
    ),
  );
*/




/*  sl.registerLazySingleton<RegisterRemoteDataSource>(
          () => RegisterRemoteDataSourceImpWithDio(dio: sl()));*/

/*  sl.registerLazySingleton<LoginRemoteDataSource>(
          () => LoginRemoteDataSourceImpWithDio(dio: sl()));
  sl.registerLazySingleton<LoginLocalDataSource>(
          () => LoginLocalDataSourceImpWithSP(sharedPreferences: sl()));

 */








  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => InternetConnectionChecker());

}
