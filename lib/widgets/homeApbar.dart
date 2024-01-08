import 'dart:ui';

import 'package:ahio/themes/themes.dart';
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
          IconButton(
            icon: Icon(
              Icons.sort,
              color: colorIcon,
            ),
            onPressed: () {},
          ),
          const Spacer(),
          Image.asset(
            "images/ahiovert.png",
            width: 30,
            height: 30,
          ),
          IconButton(
            icon: Icon(
              Icons.notification_add_outlined,
              color: colorIcon,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
