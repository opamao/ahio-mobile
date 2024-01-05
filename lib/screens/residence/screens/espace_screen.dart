import 'package:ahio/home/residence/type_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Bienvenue dans l’espace d’ajout\n    de vos residence. ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromRGBO(147, 226, 55, 1),
                  fontSize: 25.sp,
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(height: 5.h),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Image.asset(
                "images/images.png",
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 272,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(147, 226, 55, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TypeScreen()));
                  },
                  child: Text(
                    "Démarrer",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
