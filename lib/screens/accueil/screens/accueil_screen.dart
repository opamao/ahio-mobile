import 'dart:convert';

import 'package:ahio/widgets/homeApbar.dart';
import 'package:ahio/widgets/itemsWidget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../../constants/constants.dart';
import '../../../models/client/list_residence_model.dart';
import '../../../themes/themes.dart';
import '../accueil.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({
    super.key,
  });

  @override
  State<AccueilScreen> createState() => AccueilScreenContent();
}

class AccueilScreenContent extends State<AccueilScreen> {

  Future<List<ResidenceClient>> fetchCagnotte() async {
    final http.Response response = await http.get(
      Uri.parse(ApiUrls.getListResidence),
      headers: {
        'Content-Type': "application/json",
        'Accept': "application/json",
      },
    );

    debugPrint(response.body.toString(), wrapWidth: 1024);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final List<dynamic> dataList = jsonResponse['data'];

      List<ResidenceClient> liste =
          dataList.map((item) => ResidenceClient.fromJson(item)).toList();

      return liste;
    } else {
      throw Exception("Une erreur s'est produite");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 250, 230),
      body: SafeArea(
        child: FutureBuilder<List<ResidenceClient>>(
          future: fetchCagnotte(),
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

            // Organisez les données par catégorie
            Map<String, List<ResidenceClient>> residencesParCategorie = {};
            residences.forEach((residence) {
              if (residencesParCategorie.containsKey(residence.category)) {
                residencesParCategorie[residence.category]!.add(residence);
              } else {
                residencesParCategorie[residence.category!] = [residence];
              }
            });

            // Créez les onglets à partir des catégories
            List<Tab> tabs = residencesParCategorie.keys
                .map((category) => Tab(text: category))
                .toList();

            // Créez les vues correspondant à chaque catégorie
            List<Widget> tabViews = residencesParCategorie.entries.map((entry) {
              String category = entry.key;
              List<ResidenceClient> residences = entry.value;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.66,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
                padding: const EdgeInsets.all(5.0),
                itemCount: residences.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailAccueilScreen(
                            residence: residences[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(3.w),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2.w),
                                ),
                              ),
                              child: residences[index].mainPhoto != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(3.w),
                                      child: Image.network(
                                        residences[index].mainPhoto!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Placeholder(),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    residences[index].district!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            residences[index].city!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          Text(
                                            residences[index].country!,
                                            style: TextStyle(
                                              color: colorPrimary,
                                              fontSize: 8.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(1.w),
                                        margin: EdgeInsets.all(2.w),
                                        decoration: BoxDecoration(
                                          color: colorPrimary,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.w),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${residences[index].price} F",
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "La nuit",
                                              style: TextStyle(
                                                fontSize: 8.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList();

            // Retournez le widget TabBarView enveloppé dans un widget DefaultTabController
            return DefaultTabController(
              length: tabs.length,
              child: Column(
                children: [
                  TabBar(
                    tabs: tabs,
                    labelColor: Colors.blue,
                    // Couleur du texte de l'onglet sélectionné
                    unselectedLabelColor: Colors
                        .grey, // Couleur du texte de l'onglet non sélectionné
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
