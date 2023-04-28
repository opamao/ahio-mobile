import 'package:ahio/common/theme.dart';
import 'package:ahio/home/location/detail_location_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

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
            backgroundColor: couleurTransparant,
            surfaceTintColor: couleurTransparant,
            shadowColor: couleurTransparant,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  labelColor: Color.fromRGBO(106, 196, 0, 1),
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      child: Text(
                        "En cours",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Terminé",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Tous",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              encours(context),
              termine(context),
              tous(context),
            ],
          ),
        ),
      ),
    );
  }

  encours(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailLocationScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Image.asset(
                            "images/bsalon.png",
                            height: 48.w,
                            width: 48.w,
                          ),
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appartement",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 6.w,
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 150,
                              child: AutoSizeText(
                                "Abidjan / Cocody cité des arts / Rue L109",
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.w,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "Du 08 Jan au 18 Jan",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 3.2.w,
                              ),
                            ),
                            const Gap(10),
                            LinearPercentIndicator(
                              animation: true,
                              animationDuration: 2500,
                              width: 150.0,
                              lineHeight: 8.0,
                              percent: 0.5,
                              barRadius: const Radius.circular(16),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.black,
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                  width: 19.w,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "En cours...",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 3.5.w,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 3,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "25.000 F",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(3),
                                    Text(
                                      "la nuit",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailLocationScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Image.asset(
                            "images/maison.png",
                            height: 48.w,
                            width: 48.w,
                          ),
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appartement",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 6.w,
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 150,
                              child: AutoSizeText(
                                "Abidjan / Cocody cité des arts / Rue L109",
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.w,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "Du 08 Jan au 18 Jan",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 3.2.w,
                              ),
                            ),
                            const Gap(10),
                            LinearPercentIndicator(
                              animation: true,
                              animationDuration: 2500,
                              width: 150.0,
                              lineHeight: 8.0,
                              percent: 0.5,
                              barRadius: const Radius.circular(16),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.black,
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                  width: 19.w,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "En cours...",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 3.5.w,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 3,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "25.000 F",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(3),
                                    Text(
                                      "la nuit",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailLocationScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Image.asset(
                            "images/sal1.png",
                            height: 48.w,
                            width: 48.w,
                          ),
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appartement",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 6.w,
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 150,
                              child: AutoSizeText(
                                "Abidjan / Cocody cité des arts / Rue L109",
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.w,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "Du 08 Jan au 18 Jan",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 3.2.w,
                              ),
                            ),
                            const Gap(10),
                            LinearPercentIndicator(
                              animation: true,
                              animationDuration: 2500,
                              width: 150.0,
                              lineHeight: 8.0,
                              percent: 0.5,
                              barRadius: const Radius.circular(16),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.black,
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                  width: 19.w,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "En cours...",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 3.5.w,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 3,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "25.000 F",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(3),
                                    Text(
                                      "la nuit",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  termine(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Image.asset(
                            "images/bsalon.png",
                            height: 48.w,
                            width: 48.w,
                          ),
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appartement",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 6.w,
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 150,
                              child: AutoSizeText(
                                "Abidjan / Cocody cité des arts / Rue L109",
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.w,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "Du 08 Jan au 18 Jan",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 3.2.w,
                              ),
                            ),
                            const Gap(10),
                            LinearPercentIndicator(
                              animation: true,
                              animationDuration: 2500,
                              width: 150.0,
                              lineHeight: 8.0,
                              percent: 1,
                              barRadius: const Radius.circular(16),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.black,
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                  width: 19.w,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Terminé",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 3.5.w,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 3,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "25.000 F",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(3),
                                    Text(
                                      "la nuit",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Image.asset(
                            "images/maison.png",
                            height: 48.w,
                            width: 48.w,
                          ),
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appartement",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 6.w,
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 150,
                              child: AutoSizeText(
                                "Abidjan / Cocody cité des arts / Rue L109",
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.w,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "Du 08 Jan au 18 Jan",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 3.2.w,
                              ),
                            ),
                            const Gap(10),
                            LinearPercentIndicator(
                              animation: true,
                              animationDuration: 2500,
                              width: 150.0,
                              lineHeight: 8.0,
                              percent: 1,
                              barRadius: const Radius.circular(16),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.black,
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                  width: 19.w,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Terminé",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 3.5.w,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 3,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "25.000 F",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(3),
                                    Text(
                                      "la nuit",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Image.asset(
                            "images/sal1.png",
                            height: 48.w,
                            width: 48.w,
                          ),
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appartement",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 6.w,
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 150,
                              child: AutoSizeText(
                                "Abidjan / Cocody cité des arts / Rue L109",
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.w,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "Du 08 Jan au 18 Jan",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 3.2.w,
                              ),
                            ),
                            const Gap(10),
                            LinearPercentIndicator(
                              animation: true,
                              animationDuration: 2500,
                              width: 150.0,
                              lineHeight: 8.0,
                              percent: 1,
                              barRadius: const Radius.circular(16),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.black,
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                  width: 19.w,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Terminé",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 3.5.w,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 3,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "25.000 F",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(3),
                                    Text(
                                      "la nuit",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  tous(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailLocationScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Image.asset(
                            "images/bsalon.png",
                            height: 48.w,
                            width: 48.w,
                          ),
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appartement",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 6.w,
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 150,
                              child: AutoSizeText(
                                "Abidjan / Cocody cité des arts / Rue L109",
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.w,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "Du 08 Jan au 18 Jan",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 3.2.w,
                              ),
                            ),
                            const Gap(10),
                            LinearPercentIndicator(
                              animation: true,
                              animationDuration: 2500,
                              width: 150.0,
                              lineHeight: 8.0,
                              percent: 0.5,
                              barRadius: const Radius.circular(16),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.black,
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                  width: 19.w,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "En cours...",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 3.5.w,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 3,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "25.000 F",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(3),
                                    Text(
                                      "la nuit",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black,
            thickness: 3,
            indent: 20,
            endIndent: 20,
          ),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Image.asset(
                            "images/bsalon.png",
                            height: 48.w,
                            width: 48.w,
                          ),
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appartement",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 6.w,
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 150,
                              child: AutoSizeText(
                                "Abidjan / Cocody cité des arts / Rue L109",
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.w,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "Du 08 Jan au 18 Jan",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 3.2.w,
                              ),
                            ),
                            const Gap(10),
                            LinearPercentIndicator(
                              animation: true,
                              animationDuration: 2500,
                              width: 150.0,
                              lineHeight: 8.0,
                              percent: 1,
                              barRadius: const Radius.circular(16),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.black,
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                  width: 19.w,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Terminé",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 3.5.w,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 3,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "25.000 F",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(3),
                                    Text(
                                      "la nuit",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Image.asset(
                            "images/maison.png",
                            height: 48.w,
                            width: 48.w,
                          ),
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appartement",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 6.w,
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 150,
                              child: AutoSizeText(
                                "Abidjan / Cocody cité des arts / Rue L109",
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.w,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "Du 08 Jan au 18 Jan",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 3.2.w,
                              ),
                            ),
                            const Gap(10),
                            LinearPercentIndicator(
                              animation: true,
                              animationDuration: 2500,
                              width: 150.0,
                              lineHeight: 8.0,
                              percent: 1,
                              barRadius: const Radius.circular(16),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.black,
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                  width: 19.w,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Terminé",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 3.5.w,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 3,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "25.000 F",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(3),
                                    Text(
                                      "la nuit",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Image.asset(
                            "images/sal1.png",
                            height: 48.w,
                            width: 48.w,
                          ),
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appartement",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 6.w,
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 150,
                              child: AutoSizeText(
                                "Abidjan / Cocody cité des arts / Rue L109",
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 3.w,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "Du 08 Jan au 18 Jan",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 3.2.w,
                              ),
                            ),
                            const Gap(10),
                            LinearPercentIndicator(
                              animation: true,
                              animationDuration: 2500,
                              width: 150.0,
                              lineHeight: 8.0,
                              percent: 1,
                              barRadius: const Radius.circular(16),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.black,
                            ),
                            const Gap(10),
                            Row(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                  width: 19.w,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Terminé",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 3.5.w,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 3,
                                  indent: 5,
                                  endIndent: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "25.000 F",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(3),
                                    Text(
                                      "la nuit",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
