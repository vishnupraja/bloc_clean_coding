import 'package:flutter_clean_coding/model/user/user_model.dart';

abstract class LoginRepository {

  Future<UserModel> loginApi(dynamic data);
}