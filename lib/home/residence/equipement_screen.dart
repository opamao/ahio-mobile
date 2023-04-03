import 'package:ahio/home/residence/ajout_screen.dart';
import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class EquipementScreen extends StatefulWidget {
  const EquipementScreen({super.key});

  @override
  State<EquipementScreen> createState() => _EquipementScreenState();
}

class _EquipementScreenState extends State<EquipementScreen> {
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
              "Disposez-vous d’équipements spécifiques ?",
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
                  Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: CustomCheckBoxGroup(
                          buttonTextStyle: const ButtonTextStyle(
                            selectedColor: Colors.white,
                            unSelectedColor: Colors.black,
                            textStyle: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          autoWidth: false,
                          enableButtonWrap: true,
                          wrapAlignment: WrapAlignment.center,
                          unSelectedColor: Theme.of(context).canvasColor,
                          buttonLables: const [
                            "Parking gratuit",
                            "Conciège",
                            "Wifi",
                            "Piscine",
                            "Terrasse privée",
                            "Climatisation",
                            "Lave-linge",
                            "Bar",
                          ],
                          buttonValuesList: const [
                            "Parking gratuit",
                            "Conciège",
                            "Wifi",
                            "Piscine",
                            "Terrasse privée",
                            "Climatisation",
                            "Lave-linge",
                            "Bar",
                          ],
                          checkBoxButtonValues: (values) {
                            print(values);
                          },
                          defaultSelected: ["Climatisation"],
                          horizontal: false,
                          width: 120,
                          //height: 50,
                          selectedColor: const Color.fromRGBO(0, 0, 0, 0.18),
                          padding: 5,
                          enableShape: true,
                        ),
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
                            builder: (context) => AjouterScreen()));
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
