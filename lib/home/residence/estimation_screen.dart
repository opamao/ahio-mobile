import 'package:ahio/home/residence/publier_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EstimationScreen extends StatefulWidget {
  final List<int> equipement;
  final List<String> photos;
  final String adresse, rue, quartier, type, debut, fin;
  int? pays, ville, personne, chambre, lit, salle;

  EstimationScreen({
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
  });

  @override
  State<EstimationScreen> createState() => _EstimationScreenState();
}

class _EstimationScreenState extends State<EstimationScreen> {
  final _formkey = GlobalKey<FormState>();

  final _snackBar = const SnackBar(
    content: Text('Veuillez saisir le montant de votre résidence'),
    backgroundColor: Colors.red,
  );

  var montant = TextEditingController();

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
                  "A combien estimez-vous votre résidence ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const Gap(20),
                Text(
                  "Montant par nuit :",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.43),
                    fontSize: 13,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: montant,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "20000",
                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: 100,
                          child: Center(
                            child: Text(
                              "Fcfa",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Veuillez sélectionner la date de début séjour";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const Gap(50),
                Card(
                  color: const Color(0xFF3744E2).withOpacity(.17),
                  child: const SizedBox(
                    width: 300,
                    height: 100,
                    child: Center(
                      child: Text(
                        "L’estimation de votre résidence sera soumise à notre administrateur.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF3744E2),
                        ),
                      ),
                    ),
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
                            builder: (context) => PublierScreen(
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
                              debut: widget.debut,
                              fin: widget.fin,
                              montant: montant.text,
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
