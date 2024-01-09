import 'dart:convert';
import 'dart:typed_data';

import 'package:ahio/constants/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/widgets.dart';

class PublierScreen extends StatefulWidget {
  final List<int>? equipement;
  final List<List<int>>? photos;
  final List<String>? photosType;
  final List<String>? photosNom;
  final String? adresse, rue, quartier, type, debut, fin, montant;
  int? pays, ville, personne, chambre, lit, salle;

  PublierScreen({
    super.key,
    this.equipement,
    this.adresse,
    this.rue,
    this.quartier,
    this.type,
    this.pays,
    this.ville,
    this.personne,
    this.chambre,
    this.lit,
    this.salle,
    this.photos,
    this.debut,
    this.fin,
    this.montant,
    this.photosType,
    this.photosNom,
  });

  @override
  State<PublierScreen> createState() => _PublierScreenState();
}

class _PublierScreenState extends State<PublierScreen> {
  bool _isload = false;
  String? token, type, id = "";
  late Future<void> equipmentNamesFuture;
  late List<String> valeurs = [];

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
      id = pref.getString("id");
      equipmentNamesFuture = _fetchEquipmentNames();
    });
  }

  Future<void> _fetchEquipmentNames() async {
    print("OHHH ${widget.equipement} $token");
    print(jsonEncode(widget.equipement!.toList()));

    var response = await http.post(
      Uri.parse(ApiUrls.listEquip),
      headers: {
        'Authorization': '$type $token',
      },
      body: ({
        'equipement_id[]': jsonEncode(widget.equipement!.toList()),
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      print("data $jsonData");

      for (var item in jsonData) {
        valeurs.add(item.toString());
      }

      print(valeurs);
    } else {
      throw Exception("Échec de récupération des noms d'équipement");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 239, 216, 1.0),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Recap de votre offre",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
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
                    image: MemoryImage(Uint8List.fromList(widget.photos![0])),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    bottom: 15,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.type!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                          AutoSizeText(
                            "${widget.quartier} ${widget.adresse} ${widget.rue}",
                            maxLines: 3,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
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
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
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
                                    "${widget.personne} Personnes",
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
                                    "${widget.chambre} Chambres",
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
                                    "${widget.lit} Lits",
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
                                    "${widget.salle} Salles d'eau",
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
                            children: List.generate(valeurs.length, (index) {
                              return Row(
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
                                    valeurs[index],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              );
                            }),
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
                            "${widget.debut} - ${widget.fin}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
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
                          child: Text(
                            "${widget.montant} Fcfa",
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
      bottomNavigationBar: Container(
        color: Colors.white,
        child: _isload
            ? const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Color.fromRGBO(147, 226, 55, 1),
                    ),
                    Gap(10),
                    Text(
                      "Patientez",
                      style: TextStyle(
                        color: Color.fromRGBO(147, 226, 55, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.all(2.w),
                child: SubmitButton(
                  "Publier",
                  onPressed: () {
                    setState(() {
                      _isload = true;
                    });
                    publier(context);
                  },
                ),
              ),
      ),
    );
  }

  Future<void> publier(BuildContext context) async {

    // Map<String, dynamic> getPhotoMap() {
    //   Map<String, dynamic> photoMap = {};
    //   for (int i = 0; i < widget.photos!.length; i++) {
    //     photoMap[i.toString()] = widget.photos![i];
    //   }
    //   return photoMap;
    // }

    Map<String, dynamic> getEquipementMap() {
      Map<String, dynamic> equipementMap = {};
      for (int i = 0; i < widget.equipement!.length; i++) {
        equipementMap[i.toString()] = widget.equipement![i];
      }
      return equipementMap;
    }

    // print(jsonEncode(getPhotoMap()));

    DateFormat originalDateFormat = DateFormat("dd/MM/yyyy");
    DateTime parsedDateDebut = originalDateFormat.parse(widget.debut!);
    DateTime parsedDateFin = originalDateFormat.parse(widget.fin!);

    DateFormat targetDateFormat = DateFormat("yyyy-MM-dd");
    String formattedDateDebut = targetDateFormat.format(parsedDateDebut);
    String formattedDateFin = targetDateFormat.format(parsedDateFin);

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("${ApiUrls.urlApi}residence"),
    );

    List<http.MultipartFile> imageFiles = [];

    List<List<int>>? photo = widget.photos;
    List<String>? photoType = widget.photosType;
    List<String>? photoNom = widget.photosNom;

    for (int i = 0; i < photo!.length; i++) {
      List<int> bytes = photo[i];
      String type = photoType![i];
      String nom = photoNom![i];

      http.MultipartFile imagePart = http.MultipartFile.fromBytes(
        'photo[]',
        Uint8List.fromList(bytes),
        filename: nom,
        contentType: MediaType('image', type),
      );
      imageFiles.add(imagePart);
    }

    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = '$type $token';

    for (var imageFile in imageFiles) {
      request.files.add(imageFile);
    }

    request.fields['type_residence_id'] = widget.type!;
    request.fields['proprietaire_id'] = id.toString();
    request.fields['longitude'] = "5.3600";
    request.fields['latitude'] = "4.0083";
    request.fields['adresse'] = widget.adresse!;
    request.fields['rue'] = widget.rue!;
    request.fields['quartier'] = widget.quartier!;
    request.fields['pays_id'] = widget.pays.toString();
    request.fields['ville_id'] = widget.ville.toString();
    request.fields['nbre_personnes'] = widget.personne.toString();
    request.fields['nbre_chambres'] = widget.chambre.toString();
    request.fields['nbre_lits'] = widget.lit.toString();
    request.fields['nbre_salle_eau'] = widget.salle.toString();
    request.fields['equipement_id'] = jsonEncode(getEquipementMap());
    request.fields['date_debut'] = formattedDateDebut;
    request.fields['date_fin'] = formattedDateFin;
    request.fields['montant_journalier'] = widget.montant!;

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      var resp = json.decode(response.body);

      print(resp);

    if (response.statusCode == 200) {

      var reponse = resp["response"];
      var message = resp["message"];

      if (reponse == 'SUCCESS') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$message"),
            backgroundColor: Colors.green,
          ),
        );

        setState(() {
          _isload = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$message"),
            backgroundColor: Colors.red,
          ),
        );

        setState(() {
          _isload = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Impossible de publier, veuillez réessayer"),
          backgroundColor: Colors.red,
        ),
      );

      setState(() {
        _isload = false;
      });
    }
  } catch (e) {
  print('Erreur lors de l\'envoi de la requête: $e');
  }
  }
}
