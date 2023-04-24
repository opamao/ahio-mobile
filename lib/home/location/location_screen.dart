import 'package:ahio/common/theme.dart';
import 'package:flutter/material.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => LocationsScreenContent();
}

class LocationsScreenContent extends State<LocationsScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: couleurFond,
          appBar: AppBar(
            title: const Text(
              "Location",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 42,
                color: Colors.black,
              ),
            ),
            backgroundColor: couleurFond,
            bottom: const TabBar(
              indicatorColor: Colors.transparent,
              labelColor: Color.fromRGBO(106, 196, 0, 1),
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: ("En cours"),
                ),
                Tab(
                  text: ("Terminé"),
                ),
                Tab(
                  text: ("Tous"),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Center(
                child: Text("EN COURS"),
              ),
              Center(
                child: Text("TERMINÉ"),
              ),
              Center(
                child: Text("TOUS"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
