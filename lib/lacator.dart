import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ahio/common/constance.dart';
import 'package:http/http.dart' as http;

class Maps extends StatefulWidget {
  final String type;

  const Maps({Key? key, required this.type}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final panelController = PanelController();
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.7;
    return Scaffold(
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
      body: SlidingUpPanel(
        backdropColor: const Color.fromARGB(255, 222, 245, 207),
        body: Column(
          children: [
            Expanded(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(51.509364, -0.128928),
                  // center: LatLng(7.546855, -5.5471), //pour la cote d'ivoire
                  zoom: 9.2,
                ),
                nonRotatedChildren: [
                  AttributionWidget.defaultWidget(
                    source: 'OpenStreetMap contributors',
                    onSourceTapped: null,
                  ),
                ],
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                ],
              ),
            ),
          ],
        ),
        controller: panelController,
        maxHeight: panelHeightOpen,
        minHeight: 180,
        defaultPanelState: PanelState.CLOSED,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        backdropTapClosesPanel: false,
        panelBuilder: (controller) {
          return Panel(
            controller: controller,
            panelController: panelController,
          );
        },
      ),
    );
  }
}

class Pays {
  int id;
  String name;

  Pays({required this.id, required this.name});

  factory Pays.fromJson(Map<String, dynamic> json) {
    return Pays(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Ville {
  final int id;
  final String name;
  final int countryId;

  Ville({required this.id, required this.name, required this.countryId});

  factory Ville.fromJson(Map<String, dynamic> json) {
    return Ville(
      id: json['id'],
      name: json['name'],
      countryId: json['pays_id'],
    );
  }
}

class Panel extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;

  Panel({Key? key, required this.controller, required this.panelController})
      : super(key: key);

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController rue = TextEditingController();
  TextEditingController quartier = TextEditingController();
  TextEditingController adresse = TextEditingController();

  List<Pays> _pays = [];
  List<Ville> _ville = [];
  int? _selectedCountryId;
  int? _selectedCityId;

  late String token, type = "";

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("access_token")!;
      type = pref.getString("token_type")!;
      _fetchPays();
    });
  }

  Future<void> _fetchPays() async {
    final response =
        await http.get(Uri.parse("${constance.urlApi}pays"), headers: {
      'Authorization': '$type $token',
    });
    final jsonData = json.decode(response.body) as List;
// On doit enlever avant la mise en prod
    print(jsonData);

    setState(() {
      _pays = jsonData.map((item) => Pays.fromJson(item)).toList();
    });
  }

  Future<void> _fetchVille(int countryId) async {
    final response = await http.get(
        Uri.parse("${constance.urlApi}getCitiesByCountry/$countryId"),
        headers: {
          'Authorization': '$type $token',
        });
    final jsonData = json.decode(response.body) as List;
    setState(() {
      _ville = jsonData.map((item) => Ville.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{'type':''}) as Map;

    return ListView(
      physics: const BouncingScrollPhysics(),
      controller: widget.controller,
      children: <Widget>[
        Center(
            child: Container(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
              child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Saisir votre adresse",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: adresse,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    hintText: "adresse",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.location_on_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: rue,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    hintText: "  rue",
                    suffixIcon: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.edit),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: quartier,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    hintText: "  quartier",
                    suffixIcon: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.edit),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: <Widget>[
                    DropdownButtonFormField<Pays>(
                      value: _selectedCountryId != null
                          ? _pays.firstWhere((c) => c.id == _selectedCountryId)
                          : null,
                      hint: const Text('Selectionner le pays'),
                      items: _pays
                          .map((pays) => DropdownMenuItem<Pays>(
                                value: pays,
                                child: Text(pays.name),
                              ))
                          .toList(),
                      onChanged: (pays) {
                        setState(() {
                          _selectedCountryId = pays?.id;
                          _selectedCityId = null;
                        });
                        _fetchVille(pays!.id);
                      },
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<Ville>(
                      decoration: const InputDecoration(),
                      value: _selectedCityId != null
                          ? _ville.firstWhere((c) => c.id == _selectedCityId)
                          : null,
                      hint: const Text('Selectionner la ville'),
                      items: _ville
                          .map((ville) => DropdownMenuItem<Ville>(
                                value: ville,
                                child: Text(ville.name),
                              ))
                          .toList(),
                      onChanged: (ville) {
                        setState(() {
                          _selectedCityId = ville?.id;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300.0,
                  height: 50.0,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#93E237"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/capacite', arguments: {
                          "adresse": adresse.text,
                          "rue": rue.text,
                          "quartier": quartier.text,
                          "pays": _selectedCountryId,
                          "ville": _selectedCityId,
                          "type": arguments["type"],
                        });
                      },
                      child: const Text(
                        "   Suivant    ",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          )),
        )),
      ],
    );
  }
}
