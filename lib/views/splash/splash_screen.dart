import 'package:flutter/material.dart';
import 'package:flutter_clean_coding/services/splash/splash_service.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final SplashService _services = SplashService();

  @override
  void initState() {
    super.initState();
    _services.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Center(child: Text("Splash Screen",style: TextStyle(fontSize: 20),),)
            ],
          ),
        ),
      ),
    );
  }
}
