import 'package:flutter/material.dart';
import 'package:flutter_clean_coding/dependency_injector/locator.dart';
import 'package:flutter_clean_coding/repository/auth/login_http_repository.dart';
import 'package:flutter_clean_coding/repository/auth/login_repository.dart';
import 'package:flutter_clean_coding/repository/favorite/favorite_http_repository.dart';
import 'package:flutter_clean_coding/repository/favorite/favorite_repo.dart';
import 'package:flutter_clean_coding/repository/movie_repository/movies_http_repository.dart';
import 'package:flutter_clean_coding/repository/movie_repository/movies_repository.dart';
import 'package:get_it/get_it.dart';
import 'config/routes/route_name.dart';
import 'config/routes/routes.dart';

ServiceLocator dependencyLocator = ServiceLocator();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dependencyLocator.serviceLocator();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Coding',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}


