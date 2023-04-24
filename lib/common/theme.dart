import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Themehelper {
  InputDecoration? textIputDecoration(
      [String labelText = "", String hintText = ""]) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.white)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.white)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }
}

BoxDecoration inputBoxDecorationShaddow() {
  return BoxDecoration(boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 20,
      offset: const Offset(0, 5),
    )
  ]);
}

ButtonStyle buttonStyle() {
  return ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
    minimumSize: MaterialStateProperty.all(Size(50, 50)),
    backgroundColor: MaterialStateProperty.all(Colors.transparent),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
  );
}

AlertDialog alartDialog(String title, String content, BuildContext context) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black38)),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          "OK",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}

class LoginFormStyle {}

//Les differentes couleurs de l'application
Color couleurFond = const Color.fromRGBO(147, 226, 55, .7);
Color couleurTransparant = Colors.transparent;
