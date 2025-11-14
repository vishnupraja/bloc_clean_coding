import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_coding/config/routes/route_name.dart';
import 'package:flutter_clean_coding/services/session_manager/session_controller.dart';

class SplashService {
  void isLogin(BuildContext context) {

    SessionController().getUserFormSession().then((value) => {
      if(SessionController().isLogin ?? false){
        Timer((const Duration(seconds: 3)), () => Navigator.pushNamedAndRemoveUntil(context, RouteName.homeScreen, (route) => false))
      }else{
        Timer((const Duration(seconds: 3)), () => Navigator.pushNamedAndRemoveUntil(context, RouteName.loginScreen, (route) => false))
      }
    }).catchError((error,stacktrace) {
      Timer((const Duration(seconds: 3)), () => Navigator.pushNamedAndRemoveUntil(context, RouteName.loginScreen, (route) => false));
    });
  }
}
