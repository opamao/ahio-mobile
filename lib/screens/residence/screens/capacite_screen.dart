import 'package:flutter/material.dart';

import '../residence.dart';

class CapaciteScreen extends StatefulWidget {
  final String adresse;
  final String rue;
  final String quartier;
  final String type;
  final int? pays;
  final int? ville;

  const CapaciteScreen({
    Key? key,
    required this.adresse,
    required this.rue,
    required this.quartier,
    this.pays,
    this.ville,
    required this.type,
  }) : super(key: key);

  @override
  State<CapaciteScreen> createState() => _CapaciteScreenState();
}

class _CapaciteScreenState extends State<CapaciteScreen> {
  int nbrPer = 0;
  int nbrCha = 0;
  int nbrLit = 0;
  int nbrSal = 0;

  void add() {
    setState(() {
      nbrPer++;
    });
  }

  void minus() {
    setState(() {
      if (nbrPer != 0) nbrPer--;
    });
  }

  void addCha() {
    setState(() {
      nbrCha++;
    });
  }

  void minusCha() {
    setState(() {
      if (nbrCha != 0) nbrCha--;
    });
  }

  void addLit() {
    setState(() {
      nbrLit++;
    });
  }

  void minusLit() {
    setState(() {
      if (nbrLit != 0) nbrLit--;
    });
  }

  void addSal() {
    setState(() {
      nbrSal++;
    });
  }

  void minusSal() {
    setState(() {
      if (nbrSal != 0) nbrSal--;
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
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Quelle est la capacité de votre résidence ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        "images/nbrepers.png",
                        height: 60,
                        width: 80,
                      ),
                      const Text(
                        "Nombre \nde personne",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          FloatingActionButton.small(
                            heroTag: 'btn1',
                            onPressed: minus,
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('$nbrPer',
                                style: const TextStyle(fontSize: 19)),
                          ),
                          FloatingActionButton.small(
                            heroTag: 'btn2',
                            onPressed: add,
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        "images/nbrecha.png",
                        height: 60,
                        width: 80,
                      ),
                      const Text(
                        "Nombre \nde chambre",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          FloatingActionButton.small(
                            heroTag: 'btn3',
                            onPressed: minusCha,
                            backgroundColor: Colors.white,
                            child:
                                const Icon(Icons.remove, color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('$nbrCha',
                                style: const TextStyle(fontSize: 19)),
                          ),
                          FloatingActionButton.small(
                            heroTag: 'btn4',
                            onPressed: addCha,
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        "images/nbrelit.png",
                        height: 60,
                        width: 80,
                      ),
                      const Text(
                        "Nombre de \nlit",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          FloatingActionButton.small(
                            heroTag: 'btn5',
                            onPressed: minusLit,
                            backgroundColor: Colors.white,
                            child:
                                const Icon(Icons.remove, color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('$nbrLit',
                                style: const TextStyle(fontSize: 19)),
                          ),
                          FloatingActionButton.small(
                            heroTag: 'btn6',
                            onPressed: addLit,
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        "images/nbresalle.png",
                        height: 60,
                        width: 80,
                      ),
                      const Text(
                        "Nombre de \nsalle d’eau",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          FloatingActionButton.small(
                            heroTag: 'btn7',
                            onPressed: minusSal,
                            backgroundColor: Colors.white,
                            child:
                                const Icon(Icons.remove, color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('$nbrSal',
                                style: const TextStyle(fontSize: 19)),
                          ),
                          FloatingActionButton.small(
                            heroTag: 'btn8',
                            onPressed: addSal,
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EquipementScreen(
                          adresse: widget.adresse,
                          rue: widget.rue,
                          quartier: widget.quartier,
                          pays: widget.pays,
                          ville: widget.ville,
                          type: widget.type,
                          personne: nbrPer,
                          chambre: nbrCha,
                          lit: nbrLit,
                          salle: nbrSal,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Suivant",
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
