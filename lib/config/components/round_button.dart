import 'package:flutter/material.dart';
import 'package:flutter_clean_coding/config/color/colors.dart';

class RoundButton extends StatefulWidget {
  final double height;
  final Widget title;
  final VoidCallback onTap;
  const RoundButton({super.key,this.height =40, required this.onTap,required this.title});

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10)
        ),
        child:  Center(
          child: widget.title,
        ),
      ),
    );
  }
}
