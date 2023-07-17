import 'package:ahio/home/residence/capacite_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../common/constance.dart';
import '../../lacator.dart';

class TypeScreen extends StatefulWidget {
  const TypeScreen({super.key});

  @override
  State<TypeScreen> createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  int selected = 0;
  String libelle = "";

  Widget customRadio(
      String image, String titre, String description, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selected = index;
          libelle = titre;
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: (selected == index)
            ? Colors.transparent
            : const Color.fromRGBO(21, 22, 21, 0.3),
        foregroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(
            color: (selected == index)
                ? const Color.fromRGBO(147, 226, 55, 1)
                : const Color.fromRGBO(21, 22, 21, 0.0),
            width: 3.0),
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            height: 100,
            width: 100,
          ),
          Column(
            children: [
              Text(
                titre,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal),
              )
            ],
          )
        ],
      ),
    );
  }

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
            const Gap(10),
            Text(
              "Quel est le type de Résidence disposez-vous ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
            const Gap(20),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: customRadio(
                      "images/appartement.png",
                      "Un appartement",
                      "Lorem ipsum dolor sit\namet, consetetur",
                      1,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: customRadio(
                      "images/villas.png",
                      "Une villa",
                      "Lorem ipsum dolor sit\namet, consetetur",
                      2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: customRadio(
                      "images/chambre.png",
                      "Une chambre",
                      "Lorem ipsum dolor sit\namet, consetetur",
                      3,
                    ),
                  ),
                ],
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
                  Navigator.pushNamed(context, '/locator',
                      arguments: {"type": libelle});
                },
                child: Text(
                  "Suivant",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
