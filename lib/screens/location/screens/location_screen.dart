import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../constants/api_url.dart';
import '../../../models/client/list_reservation_model.dart';
import '../../../utils/utils.dart';
import '../location.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => LocationsScreenContent();
}

class LocationsScreenContent extends State<LocationsScreen> {
  Future<List<ListReservationClient>> fetchLocation() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      Uri.parse(ApiUrls.getListReservation),
      headers: {
        'Content-Type': "application/json",
        'Accept': "application/json",
        'Authorization': "Bearer ${pref.getString("access_token")}",
      },
    );

    debugPrint(response.body.toString(), wrapWidth: 1024);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final List<dynamic> dataList = jsonResponse['data'];

      List<ListReservationClient> list =
          dataList.map((item) => ListReservationClient.fromJson(item)).toList();

      return list;
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Location",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 42,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromARGB(255, 239, 250, 230),
      body: SafeArea(
        child: FutureBuilder<List<ListReservationClient>>(
          future: fetchLocation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Une erreur s'est produite."),
              );
            }

            final residences = snapshot.data;

            if (residences == null || residences.isEmpty) {
              return const Center(
                child: Text("Aucune résidence disponible."),
              );
            }

            Map<String, List<ListReservationClient>> residencesParStatus = {};
            for (var residence in residences) {
              if (residencesParStatus.containsKey(residence.state)) {
                residencesParStatus[residence.state]!.add(residence);
              } else {
                residencesParStatus[residence.state!] = [residence];
              }
            }

            List<Tab> tabs = residencesParStatus.keys.map((status) {
              String tabText;
              switch (status) {
                case 'confirmed':
                  tabText = 'Confirmée';
                  break;
                case 'approved':
                  tabText = 'Approuvée';
                  break;
                case 'cancelled':
                  tabText = 'Annulée';
                  break;
                case 'rejected':
                  tabText = 'Rejetée';
                  break;
                case 'completed':
                  tabText = 'Terminée';
                  break;
                default:
                  tabText = 'Tous';
              }
              return Tab(
                child: Text(
                  tabText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList();

            List<Widget> tabViews = residencesParStatus.entries.map((entry) {
              List<ListReservationClient> locations = entry.value;

              return ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailLocationScreen(location: locations[index]),
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
                            Expanded(
                              child: Container(
                                height: 22.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2.w),
                                  ),
                                ),
                                child: locations[index].residenceMainPhoto !=
                                        null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(3.w),
                                        child: Image.network(
                                          locations[index]
                                              .residenceMainPhoto!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Placeholder(),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    locations[index].residenceOwnerAddress!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 4.w,
                                    ),
                                  ),
                                  const Gap(10),
                                  SizedBox(
                                    width: 150,
                                    child: AutoSizeText(
                                      "${locations[index].residenceOwnerAddress!} ${locations[index].residenceStreet!}",
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
                                    "${formatDates(locations[index].startDate!)} ${formatDates(locations[index].endDate!)}",
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
                                              Radius.circular(15),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${locations[index].residencePrice!} F",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 4.w,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Gap(3),
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList();

            return DefaultTabController(
              length: tabs.length,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    tabs: tabs,
                    labelColor: const Color.fromRGBO(106, 196, 0, 1),
                    unselectedLabelColor: Colors.grey,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: TabBarView(
                        children: tabViews,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
