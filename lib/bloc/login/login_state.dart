part of 'login_bloc.dart';

class LoginStates extends Equatable {
  final String email;
  final String password;
  final String message;
  final ApiStatus apiStatus;

  const LoginStates({
    this.email = "",
    this.password = "",
    this.message = "",
    this.apiStatus = ApiStatus.initial,
  });

  LoginStates copyWith(
      {String? email,
      String? password,
      String? message,
      ApiStatus? apiStatus}) {
    return LoginStates(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }

  @override
  List<Object> get props => [email, password, apiStatus];
}
