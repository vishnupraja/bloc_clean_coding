
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_coding/model/user/user_model.dart';

import '../storage/local_storage.dart';

class SessionController{

  static final SessionController _session = SessionController._internal();

  LocalStorage localStorage = LocalStorage();
  UserModel user = UserModel();
  bool? isLogin;

  SessionController._internal(){
    isLogin = false;
  }

  factory SessionController(){
    return _session;
  }

    Future<void> saveUserSession(dynamic user) async{
       localStorage.setValue("token", jsonEncode(user));
       localStorage.setValue("isLogin", "true");
    }

    Future<void> getUserFormSession()async{

    try{
      
      var userData = await localStorage.readValue('token');
      var isLogin = await localStorage.readValue('isLogin');

      if(userData.isNotEmpty){
        SessionController().user = UserModel.fromJson(jsonDecode(userData));
      }
      SessionController().isLogin = isLogin == "true" ? true:false;

    }catch(e){
      debugPrint(e.toString());
    }

    }

}