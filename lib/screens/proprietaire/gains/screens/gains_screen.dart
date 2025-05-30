import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/constants.dart';
import '../../../../models/proprio/states_gains_model.dart';
import '../../../../themes/themes.dart';

class GainsScreen extends StatefulWidget {
  const GainsScreen({super.key});

  @override
  State<GainsScreen> createState() => _GainsScreenState();
}

class _GainsScreenState extends State<GainsScreen> {
  Future<List<StatesGains>> fetchGains() async {

    SharedPreferences pref = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      Uri.parse(ApiUrls.getNbrTotalReservation),
      headers: {
        'Authorization': "Bearer ${pref.getString("access_token")}",
        'Content-Type': "application/json",
        'Accept': "application/json",
      },
    );

    debugPrint(response.body.toString(), wrapWidth: 1024);

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body);

      List<StatesGains> liste =
      dataList.map((item) => StatesGains.fromJson(item)).toList();

      return liste;
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 250, 230),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              child: const Text(
                "Mes gains",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<StatesGains>>(
                future: fetchGains(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Erreur : ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    List<StatesGains> gainsList = snapshot.data!;
                    return ListView.builder(
                      itemCount: gainsList.length,
                      itemBuilder: (context, index) {
                        StatesGains gain = gainsList[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                    width: 4.w,
                                    color: colorPrimary,
                                    height: 4.w,
                                  ),
                                ),
                                Gap(1.h),
                                Text(
                                  "Résidence ${index + 1} (${gain.residenceReference})",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                            Gap(1.h),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3.w),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(4.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.attach_money_outlined,
                                              size: 15.sp,
                                            ),
                                            Text(
                                              "Montant par nuit :",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            Gap(2.w),
                                            Text(
                                              "${gain.price} Fcfa",
                                              style: TextStyle(
                                                color: colorPrimary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(2.h),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.nightlight_round_outlined,
                                              size: 15.sp,
                                            ),
                                            Text(
                                              "Nombre de nuit :",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            Gap(2.w),
                                            Text(
                                              "${gain.totalDays} nuits",
                                              style: TextStyle(
                                                color: colorPrimary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      /*  Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Column(
                                            children: gain.dateRanges.map((dateRange) {
                                              return Row(
                                                children: [
                                                  ClipOval(
                                                    child: Container(
                                                      width: 3.w,
                                                      color: colorPrimary,
                                                      height: 3.w,
                                                    ),
                                                  ),
                                                  Gap(1.h),
                                                  Text(
                                                    "${dateRange.start} - ${dateRange.end}",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 10.sp,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ),*/
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 5.h,
                                    decoration: BoxDecoration(
                                      color: colorPrimary,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2.5.w),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${gain.price} X ${gain.totalDays} = ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                        Text(
                                          "${gain.price! * gain.totalDays!} Fcfa",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(2.h),
                          ],
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("Aucun gains disponible"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
