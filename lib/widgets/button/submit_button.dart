import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? couleur;
  final Color? textcouleur;

  const SubmitButton(
      this.title, {
        required this.onPressed,
        this.height,
        this.width,
        this.fontSize,
        this.couleur,
        this.textcouleur,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 15.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: couleur ?? colorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.w),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize ?? 12.sp,
            color: textcouleur ?? colorWhite,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}