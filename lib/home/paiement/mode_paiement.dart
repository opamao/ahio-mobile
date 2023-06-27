import 'package:ahio/common/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ModePaiementScreen extends StatefulWidget {
  const ModePaiementScreen({super.key});

  @override
  State<ModePaiementScreen> createState() => _ModePaiementScreenState();
}

class _ModePaiementScreenState extends State<ModePaiementScreen> {
  final _formkey = GlobalKey<FormState>();

  final _snackBar = const SnackBar(
    content:
        Text('Les dates début séjour et fin séjour doivent être sélectionner'),
    backgroundColor: Colors.red,
  );

  var dateFin = TextEditingController();

  int selected = 0;
  String libelle = "";

  Widget customRadio(
      String image, String titre, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selected = index;
          libelle = titre;
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: (selected == index)
            ? Colors.transparent
            : const Color.fromRGBO(21, 22, 21, 0.3),
        foregroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(
            color: (selected == index)
                ? const Color.fromRGBO(147, 226, 55, 1)
                : const Color.fromRGBO(21, 22, 21, 0.0),
            width: 3.0),
      ),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 60,
            width: 80,
          ),
          Column(
            children: [
              Text(
                titre,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: couleurFond,
          appBar: AppBar(
            title: const Text(
              "Mode de paiement",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            backgroundColor: couleurTransparant,
            surfaceTintColor: couleurTransparant,
            shadowColor: couleurTransparant,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  labelColor: Color.fromRGBO(106, 196, 0, 1),
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      child: Text(
                        "Mobile Money",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Carte",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              mobileMoney(context),
              carte(context),
            ],
          ),
        ),
      ),
    );
    return Form(
      key: _formkey,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(225, 239, 216, 1.0),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Remplir et Payer",
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
              children: [],
            ),
          ),
        ),
      ),
    );
  }

  mobileMoney(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: customRadio(
                        "images/appartement.png",
                        "Orange Money",
                        1,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: customRadio(
                        "images/villas.png",
                        "Mtn Money",
                        2,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: customRadio(
                        "images/chambre.png",
                        "Moov Money",
                        3,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: customRadio(
                        "images/chambre.png",
                        "Wave",
                        4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  carte(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }
}
