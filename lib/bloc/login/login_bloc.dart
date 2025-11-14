import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_clean_coding/repository/auth/login_repository.dart';
import 'package:flutter_clean_coding/services/session_manager/session_controller.dart';
import 'package:flutter_clean_coding/utils/enums.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginStates>{
  final LoginRepository loginRepository;
   LoginBloc({required this.loginRepository}): super(const LoginStates()){
     on<EmailChanged>(_onEmailChanged);
     on<PasswordChanged>(_onPasswordChanged);
     on<LoginApi>(_loginApi);
   }

   void _onEmailChanged(EmailChanged event, Emitter<LoginStates> emit){
     emit(state.copyWith(email: event.email));
   }


   void _onPasswordChanged(PasswordChanged event, Emitter<LoginStates> emit){
     emit(state.copyWith(password: event.password)
     );
   }

   void _loginApi(LoginApi event, Emitter<LoginStates> emit)async{
     emit(state.copyWith(apiStatus: ApiStatus.loading));
     Map data = {
       "email": state.email,
       "password": state.password
     };
     await loginRepository.loginApi(data).then((value)async{
       if(value.error.isNotEmpty){
         emit(state.copyWith(apiStatus: ApiStatus.error, message: value.error));
       }else{
         await SessionController().saveUserSession(value);
         await SessionController().getUserFormSession();
         emit(state.copyWith(apiStatus: ApiStatus.success,message: "Login Successfully"));
       }
     }).onError((error,stacktrace){
       emit(state.copyWith(apiStatus: ApiStatus.error,message: error.toString()));
     });
   }

}