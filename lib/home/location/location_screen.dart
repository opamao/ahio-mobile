import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
          Gap(67),
          Container(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "LOCATION",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),
          Gap(20),
          Container(
            padding: const EdgeInsets.only(left: 44),
            child: Row(
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "En cours",
                      style: TextStyle(color: Colors.grey),
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Terminé",
                      style: TextStyle(color: Colors.grey),
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Tous",
                      style: TextStyle(color: Colors.green),
                    )),
              ],
            ),
          ),
          Column(
            children: [
              Gap(6),
              GridView.count(
                childAspectRatio: 0.9,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 1,
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: Image.asset("images/sal1.png"),
                            ),
                            Gap(4),
                            Column(
                              children: [
                                const Text(
                                  "Appartement",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
