import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../../models/client/list_residence_model.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/utils.dart';

class DetailResidenceScreen extends StatelessWidget {

  ResidenceClient? residence;

  DetailResidenceScreen({
    super.key,
    this.residence,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 239, 216, 1.0),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Détails",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 400,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: NetworkImage(residence!.mainPhoto!),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(3.w),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, bottom: 15),
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3.w),
                            bottomLeft: Radius.circular(3.w),
                          ),
                        ),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  residence!.category!,
                                  style: TextStyle(
                                    color: colorBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: AutoSizeText(
                                    "${residence!.city!} ${residence!.district!} \n${residence!.country!}",
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: colorBlack,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${residence!.price!} F",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Text(
                                  " /nuit",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  color: const Color.fromRGBO(225, 239, 216, 1.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Capacité de la résidence :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 8,
                          ),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "images/nbrepers.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  Text(
                                    "${residence!.personsSupported!} Personnes",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "images/nbrecha.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  Text(
                                    "${residence!.rooms!} Chambres",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "images/nbrelit.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  Text(
                                    "${residence!.beds!} Lits",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "images/nbresalle.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                  Text(
                                    "${residence!.bathrooms!} Salles d'eau",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
                        const Text(
                          "Équipements spécifiques :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 8,
                          ),
                          child: Column(
                            children: buildEquipmentWidgets(residence!.equipments!),
                          ),
                        ),
                        const Gap(20),
                        const Text(
                          "Disponibilité :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 8,
                          ),
                          child: Text(
                            "Du ${formatDates(residence!.availableAt!)} au ${formatDates(residence!.availableUntil!)}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Gap(20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildEquipmentWidgets(List<Equipments>? equipments) {
    List<Widget> widgets = [];

    for (var equipment in equipments!) {
      widgets.add(
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
            const Gap(10),
            Text(
              equipment.name!, // Affiche le nom de l'équipement
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      );
    }

    return widgets;
  }
}
