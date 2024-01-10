import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../menu/menu.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: HexColor("#93E237")),
      child: Stack(
        children: [
          Positioned(
            top: 290,
            left: 150,
            child: Image.asset(
              "images/ahio.png",
              width: 100,
            ),
          ),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}