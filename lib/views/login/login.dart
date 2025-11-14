import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_coding/bloc/login/login_bloc.dart';
import 'package:flutter_clean_coding/config/components/loading_widget.dart';
import 'package:flutter_clean_coding/config/components/round_button.dart';
import 'package:flutter_clean_coding/config/routes/route_name.dart';
import 'package:flutter_clean_coding/main.dart';
import 'package:flutter_clean_coding/utils/enums.dart';
import 'package:flutter_clean_coding/utils/flush_bar_helper.dart';
import 'package:get_it/get_it.dart';
import '../../dependency_injector/locator.dart';
import 'widgets/widget.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final _globalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(loginRepository: getIt()),
      child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Login"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmailInputWidget(emailFocusNode: emailFocusNode),
                      const SizedBox(height: 20,),
                      PasswordInputWidget(passwordFocusNode: passwordFocusNode),
                      const SizedBox(height: 20,),
                      BlocConsumer<LoginBloc,LoginStates>(
                          listenWhen: (previous, current) => previous.apiStatus != current.apiStatus,
                          listener: (context,state) {
                            if(state.apiStatus == ApiStatus.success){
                              Navigator.pushNamedAndRemoveUntil(context, RouteName.favoriteScreen, (route) => false);
                            }else if(state.apiStatus == ApiStatus.error){
                              FlushBarHelper.flushBarErrorMessage(state.message, context,isError: true);
                            }
                          },
                        builder: (context, state) {
                          return RoundButton(onTap: (){
                            if(_globalKey.currentState!.validate()){
                              context.read<LoginBloc>().add(LoginApi());
                            }
                          }, title: state.apiStatus == ApiStatus.loading ? const LoadingWidget(size: 30,):const Text("Login"));
                        }
                      )
                    ],
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
}
