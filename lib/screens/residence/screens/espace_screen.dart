import 'package:ahio/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../residence.dart';

class EspaceScreen extends StatelessWidget {
  const EspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 239, 216, 1.0),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              Text(
                "Bienvenue dans l’espace d’ajout\n    de vos residence. ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromRGBO(147, 226, 55, 1),
                  fontSize: 25.sp,
                ),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Image.asset(
                  "images/images.png",
                ),
              ),
              const Spacer(),
              SubmitButton(
                "Démarrer",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TypeScreen(),
                    ),
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
