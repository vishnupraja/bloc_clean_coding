import 'package:flutter/material.dart';
import '../../views/views.dart';
import 'route_name.dart';

class Routes {

 static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name){
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.favoriteScreen:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
        case RouteName.imagePickerScreen:
        return MaterialPageRoute(builder: (_) => const ImagePickerScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'No Route Generated',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
    }
  }
}