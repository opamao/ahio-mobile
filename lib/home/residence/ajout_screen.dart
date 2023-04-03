import 'package:ahio/home/residence/photo_screen.dart';
import 'package:flutter/material.dart';

class AjouterScreen extends StatelessWidget {
  const AjouterScreen({super.key});

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
            const SizedBox(height: 20),
            const Text(
              "Nous sommes impatient de découvrir votre résidence",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Ajouter des photos",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/ajoutun.png",
                    ),
                    Image.asset(
                      "images/ajoutdeux.png",
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.insert_photo_rounded,
                    color: Colors.black,
                  ),
                  label: const Text(
                    "Prendre photo",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                Image.asset("images/ajouttrois.png"),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 272,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(147, 226, 55, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PhotoScreen()));
                },
                child: const Text(
                  "Suivant",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
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
