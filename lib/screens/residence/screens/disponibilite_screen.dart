import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import '../residence.dart';

class DisponibiliteScreen extends StatefulWidget {
  final List<int> equipement;
  final List<String> photos;
  final String adresse, rue, quartier, type;
  int? pays, ville, personne, chambre, lit, salle;

  DisponibiliteScreen({
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
  });

  @override
  State<DisponibiliteScreen> createState() => _DisponibiliteScreenState();
}

class _DisponibiliteScreenState extends State<DisponibiliteScreen> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  final _formkey = GlobalKey<FormState>();

  final _snackBar = const SnackBar(
    content:
        Text('Les dates début séjour et fin séjour doivent être sélectionner'),
    backgroundColor: Colors.red,
  );

  var dateDebut = TextEditingController();
  var dateFin = TextEditingController();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} - ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        dateDebut = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(args.value.startDate),
        );
        dateFin = TextEditingController(
          text: DateFormat('dd/MM/yyyy')
              .format(args.value.endDate ?? args.value.startDate),
        );
      }
    });
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
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const Gap(20),
                const Text(
                  "Quelle est la disponibilité De votre bien ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, .16),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: SfDateRangePicker(
                          onSelectionChanged: _onSelectionChanged,
                          view: DateRangePickerView.month,
                          selectionMode: DateRangePickerSelectionMode.range,
                          startRangeSelectionColor: Colors.green,
                          endRangeSelectionColor: Colors.green,
                          rangeSelectionColor: Colors.lightGreen,
                          initialSelectedRange: PickerDateRange(
                            DateTime.now().subtract(
                              const Duration(days: 4),
                            ),
                            DateTime.now().add(
                              const Duration(days: 3),
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Column(
                        children: [
                          TextFormField(
                            controller: dateDebut,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Début",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Icon(Icons.date_range_outlined),
                                      Text(
                                        "Début séjour :",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez sélectionner la date de début séjour";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const Gap(10),
                          TextFormField(
                            controller: dateFin,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Fin",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: 90,
                                  child: Row(
                                    children: [
                                      Icon(Icons.date_range_outlined),
                                      Text(
                                        "Fin séjour :",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez sélectionner la date de fin séjour";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                SizedBox(
                  width: 272,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(147, 226, 55, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EstimationScreen(
                              equipement: widget.equipement,
                              adresse: widget.adresse,
                              rue: widget.rue,
                              quartier: widget.quartier,
                              type: widget.type,
                              pays: widget.pays,
                              ville: widget.ville,
                              personne: widget.personne,
                              chambre: widget.chambre,
                              lit: widget.lit,
                              salle: widget.salle,
                              photos: widget.photos,
                              debut: dateDebut.text,
                              fin: dateFin.text,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      }
                    },
                    child: const Text(
                      "Suivant",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
