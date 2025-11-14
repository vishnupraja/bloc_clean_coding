

import 'package:flutter_clean_coding/config/app_urls/app_url.dart';
import 'package:flutter_clean_coding/data/network/network_api_service.dart';
import 'package:flutter_clean_coding/model/user/user_model.dart';
import 'login_repository.dart';

class LoginHttpRepository implements LoginRepository{

  final _api = NetworkApiServices();

  @override
  Future<UserModel> loginApi(dynamic data) async{
    final res = await _api.postData(AppUrls.loginUrl, data);
    return UserModel.fromJson(res);
  }

}