import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/constants.dart';
import '../../../models/client/list_favoris_model.dart';
import '../../../models/client/list_residence_model.dart';
import '../../../themes/themes.dart';
import '../../accueil/accueil.dart';

class FavorisScreen extends StatefulWidget {
  const FavorisScreen({super.key});

  @override
  State<FavorisScreen> createState() => FavorisScreenContent();
}

class FavorisScreenContent extends State<FavorisScreen> {
  Future<List<ResidenceClient>> fetchResidence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString("access_token");

    final http.Response response = await http.get(
      Uri.parse(ApiUrls.getListFavourites),
      headers: {
        'Authorization': "Bearer $accessToken",
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(40),
          Container(
            padding: const EdgeInsets.only(left: 25),
            child: const Text(
              "FAVORIS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: FutureBuilder<List<ResidenceClient>>(
              future: fetchResidence(),
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
                for (var residence in residences) {
                  if (residencesParCategorie
                      .containsKey(residence.category)) {
                    residencesParCategorie[residence.category]!
                        .add(residence);
                  } else {
                    residencesParCategorie[residence.category!] = [
                      residence
                    ];
                  }
                }

                // Créez les onglets à partir des catégories
                List<Tab> tabs = residencesParCategorie.keys
                    .map(
                      (residenceType) => Tab(
                        child: Text(
                          residenceType,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                    .toList();

                // Créez les vues correspondant à chaque catégorie
                List<Widget> tabViews =
                    residencesParCategorie.entries.map((entry) {
                  List<ResidenceClient> residences = entry.value;

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  child: residences[index].mainPhoto !=
                                          null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(3.w),
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
                                      Row(
                                        children: [
                                          Text(
                                            residences[index].district!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          const Spacer(),
                                          Image.asset(
                                            "images/favorisIcon.png",
                                            width: 35,
                                            height: 35,
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  residences[index]
                                                      .city!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 10.sp,
                                                  ),
                                                ),
                                                Text(
                                                  residences[index]
                                                      .address!,
                                                  style: TextStyle(
                                                    color: colorPrimary,
                                                    fontSize: 8.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            const SizedBox(
                                              height: 30,
                                              width: 20,
                                              child: VerticalDivider(
                                                  color: Colors.green),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
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
                                            )
                                          ],
                                        ),
                                      ),
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
                      Container(
                        color: Colors.white,
                        margin: const EdgeInsets.only(left: 20),
                        height: 40,
                        child: TabBar(
                          isScrollable: true,
                          indicatorColor: Colors.transparent,
                          tabs: tabs,
                          labelColor: const Color.fromRGBO(106, 196, 0, 1),
                          unselectedLabelColor: Colors.grey,
                        ),
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
        ],
      ),
    );
  }
}
