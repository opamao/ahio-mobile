import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeApbar extends StatelessWidget {
  const HomeApbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Row(
        children: [
          const Icon(
            Icons.sort,
            color: Color(0xFF475269),
          ),
          const SizedBox(width: 230),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset(
              "images/ahiovert.png",
              width: 30,
              height: 30,
            ),
          ),
          IconButton(
            icon: Icon(Icons.notification_add_outlined),
            color: Color(0xFF475269),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
