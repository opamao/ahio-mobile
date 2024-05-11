import 'dart:convert';
import 'dart:io';

import 'package:ahio/models/client/list_residence_model.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../menu/menu.dart';

class ModePaiementScreen extends StatefulWidget {
  ResidenceClient? residence;
  String? dateDebut;
  String? dateFin;

  ModePaiementScreen({
    super.key,
    this.residence,
    this.dateDebut,
    this.dateFin,
  });

  @override
  State<ModePaiementScreen> createState() => _ModePaiementScreenState();
}

class _ModePaiementScreenState extends State<ModePaiementScreen> {
  final _formkey = GlobalKey<FormState>();

  var dateFin = TextEditingController();

  int selected = 0;
  String libelle = "";

  Widget customRadio(String image, String titre, int index) {
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
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 239, 250, 230),
          appBar: AppBar(
            title: const Text(
              "Mode de paiement",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(4.w),
        child: SubmitButton(
          Constants.reserver,
          onPressed: () {
              reserve(context);
          },
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
    return const SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }

  Future<void> reserve(BuildContext context) async {
    QuickAlert.show(
      disableBackBtn: true,
      context: context,
      type: QuickAlertType.warning,
      title: "Veuillez patienter...",
      showConfirmBtn: false,
    );

    SharedPreferences pref = await SharedPreferences.getInstance();

    HttpClient().badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    final http.Response respons = await http.post(
      Uri.parse(ApiUrls.postCreateReservation),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer ${pref.getString("access_token")}",
      },
      body: jsonEncode({
        'residence_id': widget.residence!.id,
        'start_date': formatDateTime(widget.dateDebut!),
        'end_date': formatDateTime(widget.dateFin!),
        'persons': widget.residence!.personsSupported,
      }),
    );

    Navigator.pop(context);

    var resp = jsonDecode(respons.body);

    print(resp);
    print(respons.statusCode);

    if (respons.statusCode == 201) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Votre réservation a été prise en compte"),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
            (route) => false,
      );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Impossible de faire la réservation. Veuillez réessayer"),
        ),
      );
    }
  }
}
