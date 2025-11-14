import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color/colors.dart';

class LoadingWidget extends StatefulWidget {
  final double size;
  final Color color;
  const LoadingWidget({super.key,this.size = 50,this.color = AppColors.white});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: Platform.isAndroid
          ?  CircularProgressIndicator(color: widget.color,)
          : const CupertinoActivityIndicator(color: AppColors.primary,),
    );
  }
}
