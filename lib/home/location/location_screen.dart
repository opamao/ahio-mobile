import 'package:flutter/material.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => LocationsScreenContent();
}

class LocationsScreenContent extends State<LocationsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 250, 230),
      body: ListView(
        children: [
          Text("location"),
        ],
      ),
    );
  }
}
