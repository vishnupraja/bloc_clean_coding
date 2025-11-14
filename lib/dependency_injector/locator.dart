import 'package:dio/dio.dart';
import 'dependency_injector.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator{
  void serviceLocator() {
    getIt.registerLazySingleton<LoginRepository>(() => LoginHttpRepository());
    getIt.registerLazySingleton<MoviesRepository>(() => MoviesHttpRepository());
    getIt.registerLazySingleton<FavoriteRepository>(() => FavoriteHttpRepository());
    getIt.registerLazySingleton<Dio>(() => Dio());
  }
}