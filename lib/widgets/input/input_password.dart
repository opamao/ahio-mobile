import 'package:ahio/common/input/input.dart';
import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  final TextEditingController controller;
  final String validatorMessage;
  final String? hintText;
  final Widget? prefixIcon;

  const InputPassword({
    Key? key,
    required this.controller,
    required this.validatorMessage,
    this.hintText,
    this.prefixIcon,
    required IconButton suffixIcon,
  }) : super(key: key);

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return InputText(
      controller: widget.controller,
      validatorMessage: widget.validatorMessage,
      obscureText: _obscure,
      prefixIcon: widget.prefixIcon,
      hintText: widget.hintText,
      suffixIcon: IconButton(
        icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(
            () {
              _obscure = !_obscure;
            },
          );
        },
      ),
    );
  }
}
