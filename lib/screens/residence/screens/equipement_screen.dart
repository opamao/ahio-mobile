import 'dart:convert';

import 'package:ahio/constants/constants.dart';
import 'package:ahio/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../../widgets/widgets.dart';
import '../residence.dart';

class EquipementScreen extends StatefulWidget {
  final String? adresse, rue, quartier, type;
  final int? pays, ville, personne, chambre, lit, salle;

  const EquipementScreen({
    Key? key,
    this.adresse,
    this.rue,
    this.quartier,
    this.pays,
    this.ville,
    this.personne,
    this.chambre,
    this.lit,
    this.salle,
    this.type,
  }) : super(key: key);

  @override
  State<EquipementScreen> createState() => _EquipementScreenState();
}

class _EquipementScreenState extends State<EquipementScreen> {
  late Future<List<String>> equipmentNamesFuture;
  late Future<List<int>> equipmentIdsFuture;
  late List<int> valeurs = [];

  String? token, type = "";

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("access_token");
      type = pref.getString("token_type");
      equipmentNamesFuture = _fetchEquipmentNames();
      equipmentIdsFuture = _fetchEquipmentIds();
    });
  }

  Future<List<String>> _fetchEquipmentNames() async {
    final response = await http.get(
      Uri.parse("${ApiUrls.urlApi}equipement"),
      headers: {'Authorization': '$type $token', 'Cache-Control': 'no-cache'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)["object"] as List;
      List<String> equipmentNames =
          jsonData.map((item) => item["name"] as String).toList();
      return equipmentNames;
    } else {
      throw Exception("Échec de récupération des noms d'équipement");
    }
  }

  Future<List<int>> _fetchEquipmentIds() async {
    final response = await http.get(
      Uri.parse("${ApiUrls.urlApi}equipement"),
      headers: {'Authorization': '$type $token', 'Cache-Control': 'no-cache'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)["object"] as List;
      List<int> equipmentIds =
          jsonData.map<int>((item) => item["id"] as int).toList();
      return equipmentIds;
    } else {
      throw Exception("Échec de récupération des IDs d'équipement");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 239, 216, 1.0),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Column(
            children: [
              Text(
                "Disposez-vous d’équipements spécifiques ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorBlack,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: Future.wait([equipmentNamesFuture, equipmentIdsFuture]),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erreur: ${snapshot.error}'));
                  } else {
                    List<String> equipmentNames = snapshot.data![0];
                    List<int> equipmentIds = snapshot.data![1];
                    return Center(
                      child: SingleChildScrollView(
                        child: CustomCheckBoxGroup(
                          buttonTextStyle: const ButtonTextStyle(
                            selectedColor: Colors.white,
                            unSelectedColor: Colors.black,
                            textStyle: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          autoWidth: false,
                          enableButtonWrap: true,
                          wrapAlignment: WrapAlignment.center,
                          unSelectedColor: Theme.of(context).canvasColor,
                          buttonLables: equipmentNames,
                          buttonValuesList: equipmentIds,
                          checkBoxButtonValues: (values) {
                            print(values);
                            valeurs = values;
                          },
                          horizontal: false,
                          width: 120,
                          //height: 50,
                          selectedColor: const Color.fromRGBO(12, 126, 196, 1.0),
                          padding: 5,
                          enableShape: true,
                        ),
                      ),
                    );
                  }
                },
              ),
              const Spacer(),
              SubmitButton(
                "Suivant",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AjouterScreen(
                        equipement: valeurs,
                        adresse: widget.adresse!,
                        rue: widget.rue!,
                        quartier: widget.quartier!,
                        type: widget.type!,
                        pays: widget.pays,
                        ville: widget.ville,
                        personne: widget.personne,
                        chambre: widget.chambre,
                        lit: widget.lit,
                        salle: widget.salle,
                      ),
                    ),
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
