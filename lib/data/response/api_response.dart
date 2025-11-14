
import 'package:flutter_clean_coding/utils/enums.dart';

class ApiResponse<T>{

  Status? status;
  T? data;
  String? message;

  ApiResponse(this.data,this.message,this.status);

 ApiResponse.loading() : status = Status.loading;
 ApiResponse.completed(this.data) : status = Status.completed;
 ApiResponse.error(this.message) : status = Status.error;



 @override
  String toString() {
    return 'ApiResponse(status: $status,\n data: $data,\n message: $message)';
  }


}