import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String validatorMessage;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool obscureText;
  const InputText({
    Key? key,
    required this.controller,
    required this.validatorMessage,
    this.keyboardType,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.w),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validatorMessage;
        } else {
          return null;
        }
      },
    );
  }
}
