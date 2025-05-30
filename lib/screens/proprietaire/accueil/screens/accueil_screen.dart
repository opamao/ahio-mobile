import 'dart:convert';

import 'package:ahio/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/constants.dart';
import '../../../../models/proprio/states_model.dart';
import '../../../../themes/themes.dart';
import '../../../../widgets/widgets.dart';
import '../../../residence/residence.dart';

class AccueilProprioScreen extends StatefulWidget {
  const AccueilProprioScreen({super.key});

  @override
  State<AccueilProprioScreen> createState() => _AccueilProprioScreenState();
}

class _AccueilProprioScreenState extends State<AccueilProprioScreen> {
  Future<States> fetchStates() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final http.Response response = await http.get(
      Uri.parse(ApiUrls.getStatistic),
      headers: {
        'Authorization': "Bearer ${pref.getString("access_token")}",
        'Content-Type': "application/json",
        'Accept': "application/json",
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      States states = States.fromJson(jsonResponse);
      return states;
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  List<_SalesData> convertStatesToSalesData(States states) {
    return [
      _SalesData('Total RS', (states.totalResidences ?? 0).toDouble()),
      _SalesData('Active', (states.totalResidencesActive ?? 0).toDouble()),
      _SalesData('Inactive', (states.totalResidencesInactive ?? 0).toDouble()),
      _SalesData('Total RV', (states.totalReservation ?? 0).toDouble()),
      _SalesData(
          'Complètes', (states.totalReservationsCompleted ?? 0).toDouble()),
      _SalesData(
          'Annulées', (states.totalReservationsCancelled ?? 0).toDouble()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 250, 230),
      body: ListView(
        children: [
          const HomeApbar(),
          Container(
            padding: EdgeInsets.only(left: 8.w),
            child: Row(
              children: [
                Image.asset(
                  "images/image1.png",
                  width: 10.w,
                  height: 10.w,
                ),
                const Gap(10),
                Text(
                  "Les meilleurs\nrésidences sont ici !",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          const Gap(15),
          SizedBox(
            height: 30.h,
            child: Stack(
              children: [
                Positioned(
                  top: 35,
                  left: 20,
                  child: Material(
                    child: Container(
                      height: 22.h,
                      width: 92.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: const Offset(-10.0, 10.0),
                            blurRadius: 20.0,
                            spreadRadius: 4.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 30,
                  child: Card(
                    elevation: 50.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: Assets.images.home.provider(),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 45,
                  left: 180,
                  child: Container(
                    margin: EdgeInsets.only(left: 3.w),
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ajouter votre \nrésidence",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EspaceScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Démarrer maintenant >",
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: colorBlack,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          FutureBuilder<States>(
            future: fetchStates(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("Erreur : ${snapshot.error}");
              } else if (snapshot.hasData) {
                List<_SalesData> data =
                    convertStatesToSalesData(snapshot.data!);
                return SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(
                    text: 'Statistiques',
                    textStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.name,
                      yValueMapper: (_SalesData sales, _) => sales.values,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                    )
                  ],
                );
              } else {
                return const Text("Aucune donnée disponible");
              }
            },
          ),
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(
    this.name,
    this.values,
  );

  final String name;
  final double values;
}
