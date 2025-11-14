
class AppException implements Exception{
  final String? message;
  final String? prefix;
  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return "$message$prefix";
  }
}


class NotInternetException extends AppException{
  NotInternetException([String? message]) : super(message, "No Internet Connection");
}

class UnauthorisedException extends AppException{
  UnauthorisedException([String? message]) : super(message, "You don't have to access this");
}

class RequestTimeOutException extends AppException{
  RequestTimeOutException([String? message]) : super(message, "Request Time Out");
}

class BadRequestException extends AppException{
  BadRequestException([String? message]) : super(message, "Bad Request");
}

class FetchDataException extends AppException{
  FetchDataException([String? message]) : super(message, "");

}


