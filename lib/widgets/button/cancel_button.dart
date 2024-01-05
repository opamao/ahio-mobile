import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CancelButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final double? height;
  final double? fontSize;

  const CancelButton(
      this.title, {
        required this.onPressed,
        this.height,
        this.fontSize,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 15.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          surfaceTintColor: colorWhite,
          backgroundColor: colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.w),
            side: BorderSide(color: colorPrimary),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize ?? 12.sp,
            color: colorPrimary,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}