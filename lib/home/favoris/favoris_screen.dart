import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
          Gap(67),
          Container(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "FAVORIS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),
          Gap(16),
          GridView.count(
            childAspectRatio: 0.76,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/sal1.png",
                        ),
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 10)),
                            const Text(
                              "Appartement",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Gap(35),
                            Image.asset(
                              "images/favorisIcon.png",
                              width: 35,
                              height: 35,
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Abidjan",
                                    textAlign: TextAlign.start,
                                  ),
                                  Gap(3),
                                  Text(
                                    "08 Jan - 18 Jan",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Gap(4),
                                ],
                              ),
                              Gap(8),
                              Container(
                                  height: 30,
                                  width: 20,
                                  child: VerticalDivider(color: Colors.green)),
                              Column(
                                children: [
                                  Text(
                                    "25.000 F",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Gap(3),
                                  Text(
                                    "la nuit",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/maison.png",
                        ),
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 10)),
                            const Text(
                              "Villa",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Gap(94),
                            Image.asset(
                              "images/favorisIcon.png",
                              width: 35,
                              height: 35,
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Abidjan",
                                    textAlign: TextAlign.start,
                                  ),
                                  Gap(3),
                                  Text(
                                    "08 Jan - 18 Jan",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Gap(3),
                                ],
                              ),
                              Gap(8),
                              Container(
                                  height: 30,
                                  width: 20,
                                  child: VerticalDivider(color: Colors.green)),
                              Column(
                                children: [
                                  Text(
                                    "25.000 F",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Gap(3),
                                  Text(
                                    "la nuit",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/bsalon.png",
                          width: 490,
                          height: 176,
                        ),
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 10)),
                            const Text(
                              "Duplexe",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Gap(70),
                            Image.asset(
                              "images/favorisIcon.png",
                              width: 35,
                              height: 35,
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Abidjan",
                                    textAlign: TextAlign.start,
                                  ),
                                  Gap(3),
                                  Text(
                                    "08 Jan - 18 Jan",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Gap(4),
                                ],
                              ),
                              Gap(8),
                              Container(
                                  height: 30,
                                  width: 20,
                                  child: VerticalDivider(color: Colors.green)),
                              Column(
                                children: [
                                  Text(
                                    "25.000 F",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Gap(3),
                                  Text(
                                    "la nuit",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
