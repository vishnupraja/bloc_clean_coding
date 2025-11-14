

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_coding/bloc/login/login_bloc.dart';

class PasswordInputWidget extends StatelessWidget {
  final FocusNode passwordFocusNode;
  const PasswordInputWidget({super.key,required this.passwordFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc,LoginStates>(
      buildWhen: (previous, current) => current.password != previous.password,
      builder: (context,state) {
        return TextFormField(
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          focusNode: passwordFocusNode,
          decoration: const InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
            ),
          ),
          validator: (value){
            if(value!.isEmpty){
              return "Please enter password";
            }
            if(value.length < 6){
              return "Password must be 6 characters";
            }
            return null;
          },
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
        );
      }
    );
  }
}
