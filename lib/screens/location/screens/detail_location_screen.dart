import 'dart:convert';

import 'package:ahio/models/client/list_reservation_model.dart';
import 'package:ahio/utils/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';
import '../../../themes/themes.dart';

class DetailLocationScreen extends StatelessWidget {
  ListReservationClient? location;

  final DateTime startDate;
  final DateTime endDate;

  DetailLocationScreen({
    super.key,
    required this.location,
  })  : startDate = location != null &&
                location.startDate != null &&
                location.endDate != null
            ? DateTime.parse(location.startDate!.split('-').reversed.join())
            : DateTime.now(),
        endDate = location != null &&
                location.startDate != null &&
                location.endDate != null
            ? DateTime.parse(location.endDate!.split('-').reversed.join())
            : DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 239, 216, 1.0),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Détails - location",
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
                    image: NetworkImage(location!.residenceMainPhoto!),
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
                                  location!.residenceOwnerAddress!,
                                  style: TextStyle(
                                    color: colorBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: AutoSizeText(
                                    "${location!.residenceType!} ${location!.residenceStreet}",
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
                                  "${location!.residencePrice!} F",
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
                          "Période de location",
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
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "En cours...",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        color: Colors.green),
                                  ),
                                  LinearPercentIndicator(
                                    animation: true,
                                    animationDuration: 2500,
                                    width: 190.0,
                                    lineHeight: 8.0,
                                    percent: .5,
                                    barRadius: const Radius.circular(16),
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.black,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Du ${formatDates(location!.startDate!)} au ${formatDates(location!.endDate!)} = ",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${endDate.difference(startDate).inDays} nuits",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
                        const Text(
                          "Montant par nuit :",
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
                          child: Row(
                            children: [
                              Text(
                                "${location!.residencePrice} F x ${endDate.difference(startDate).inDays} = ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${location!.residencePrice! * endDate.difference(startDate).inDays} FCFA",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
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
                                    "${location!.persons} Personnes",
                                    style: const TextStyle(
                                      fontSize: 15,
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
                                    "${location!.residenceRooms} Chambres",
                                    style: const TextStyle(
                                      fontSize: 15,
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
                                    "${location!.residenceBeds} Lits",
                                    style: const TextStyle(
                                      fontSize: 15,
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
                                    "${location!.residenceBathrooms} Salles d'eau",
                                    style: const TextStyle(
                                      fontSize: 15,
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
                            children:
                                buildEquipmentWidgets(location!.equipments!),
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 90.0,
            right: 90.0,
            top: 10,
            bottom: 10,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(147, 226, 55, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () async {
              _fetchChangeStatus(context);
            },
            child: const Text(
              "Terminer",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildEquipmentWidgets(equipments) {
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
              equipment,
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

  Future<void> _fetchChangeStatus(BuildContext context) async {
    QuickAlert.show(
      disableBackBtn: true,
      context: context,
      type: QuickAlertType.warning,
      title: "Veuillez patienter...",
      showConfirmBtn: false,
    );

    SharedPreferences pref = await SharedPreferences.getInstance();

    var response = await http.post(
      Uri.parse(ApiUrls.postUpdateStatusReservation),
      headers: {
        'Authorization': "Bearer ${pref.getString("access_token")}",
        'Content-Type': "application/json",
        'Accept': "application/json",
      },
      body: jsonEncode({
        'state': "completed",
        'reservation_id': location!.id!,
      }),
    );

    Navigator.pop(context);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Vous avez terminer votre séjour avec succès"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content:
              Text("Impossible de terminer vitre séjour. Veuillez réessayer"),
        ),
      );
    }
  }
}
