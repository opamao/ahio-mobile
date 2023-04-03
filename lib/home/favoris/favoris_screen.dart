import 'package:flutter/material.dart';

class FavorisScreen extends StatefulWidget {
  const FavorisScreen({super.key});

  @override
  State<FavorisScreen> createState() => FavorisScreenContent();
}

class FavorisScreenContent extends State<FavorisScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 250, 230),
      body: ListView(
        children: [
          Text("FAVORIS"),
        ],
      ),
    );
  }
}
