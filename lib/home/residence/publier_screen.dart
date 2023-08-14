import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ahio/common/constance.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublierScreen extends StatefulWidget {
  final List<int> equipement;
  final List<String> photos;
  final String adresse, rue, quartier, type, debut, fin, montant;
  int? pays, ville, personne, chambre, lit, salle;

  PublierScreen({
    super.key,
    required this.equipement,
    required this.adresse,
    required this.rue,
    required this.quartier,
    required this.type,
    required this.pays,
    required this.ville,
    required this.personne,
    required this.chambre,
    required this.lit,
    required this.salle,
    required this.photos,
    required this.debut,
    required this.fin,
    required this.montant,
  });

  @override
  State<PublierScreen> createState() => _PublierScreenState();
}

class _PublierScreenState extends State<PublierScreen> {
  bool _isload = false;
  String? token, type, id = "";

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
    });
  }

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(widget.photos[0]);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 239, 216, 1.0),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Recap de votre offre",
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
                    image: MemoryImage(bytes),
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
                            widget.type,
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
                            children: List.generate(widget.equipement.length,
                                (index) {
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
                                    widget.equipement[index].toString(),
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
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(147, 226, 55, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _isload = true;
                    });
                    publier();
                  },
                  child: const Text(
                    "Publier",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void publier() async {

    DateFormat originalDateFormat = DateFormat("dd/MM/yyyy");
    DateTime parsedDateDebut = originalDateFormat.parse(widget.debut);
    DateTime parsedDateFin = originalDateFormat.parse(widget.fin);

    DateFormat targetDateFormat = DateFormat("yyyy-MM-dd");
    String formattedDateDebut = targetDateFormat.format(parsedDateDebut);
    String formattedDateFin = targetDateFormat.format(parsedDateFin);

    var response = await http.post(
      Uri.parse("${constance.urlApi}residence"),
      headers: {
        'Authorization': '$type $token',
      },
      body: ({
        'type_residence_id': widget.type,
        'proprietaire_id': id.toString(),
        'longitude': "5.3600",
        'latitude': "4.0083",
        'adresse': widget.adresse,
        'rue': widget.rue,
        'quartier': widget.quartier,
        'pays_id': widget.pays.toString(),
        'ville_id': widget.ville.toString(),
        'nbre_personnes': widget.personne.toString(),
        'nbre_chambres': widget.chambre.toString(),
        'nbre_lits': widget.lit.toString(),
        'nbre_salle_eau': widget.salle.toString(),
        'equipement_id[]': jsonEncode(widget.equipement.toList()),
        'date_debut': formattedDateDebut,
        'date_fin': formattedDateFin,
        'montant_journalier': widget.montant,
        'photo[]': jsonEncode(widget.photos.toList()),
      }),
    );

    if (response.statusCode == 200) {
      var resp = json.decode(response.body);

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
      print(response.body);

      setState(() {
        _isload = false;
      });
    }
  }
}
