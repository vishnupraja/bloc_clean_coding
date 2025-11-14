import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_coding/config/color/colors.dart';

class FlushBarHelper {
  static void flushBarErrorMessage(String message, BuildContext context,{bool isError = false}) {
    Flushbar(
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      forwardAnimationCurve: Curves.decelerate,
        flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(10),
      backgroundColor: isError ?AppColors.red:Colors.green,
      reverseAnimationCurve: Curves.easeInOut,
      positionOffset: 20,
      duration: const Duration(seconds: 2),

    ).show(context);
  }
}
