import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/widgets.dart';
import '../residence.dart';

class AjouterScreen extends StatefulWidget {
  final List<int>? equipement;
  final String? adresse, rue, quartier, type;
  final int? pays, ville, personne, chambre, lit, salle;

  const AjouterScreen({
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
  });

  @override
  State<AjouterScreen> createState() => _AjouterScreenState();
}

class _AjouterScreenState extends State<AjouterScreen> {
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
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              const Text(
                "Nous sommes impatient de découvrir votre résidence",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Ajouter des photos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/ajoutun.png",
                      ),
                      Image.asset(
                        "images/ajoutdeux.png",
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoScreen(
                            equipement: widget.equipement!,
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
                    icon: const Icon(
                      Icons.insert_photo_rounded,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Prendre photo",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Image.asset("images/ajouttrois.png"),
                ],
              ),
              const Spacer(),
              SubmitButton(
                "Suivant",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoScreen(
                        equipement: widget.equipement!,
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
