
import 'package:flutter_clean_coding/model/user/user_model.dart';
import 'login_repository.dart';

class LoginMockRepository implements LoginRepository{


  @override
  Future<UserModel> loginApi(dynamic data) async{
   final response ={
     'token': "fdjkhfjksdhf"
   };
    return UserModel.fromJson(response);
  }

}