import 'dart:convert';
import 'package:ahio/common/constance.dart';
import 'package:ahio/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Felicitation extends StatefulWidget {
  const Felicitation({super.key});

  @override
  State<Felicitation> createState() => _FelicitationState();
}

class _FelicitationState extends State<Felicitation> {
  String? telephone, password;

  @override
  void initState() {
    super.initState();
    getotp();
    sign();
  }

  void getotp() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      telephone = pref.getString("phone");
      password = pref.getString("password");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(0, 93, 236, 16),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/fond.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                    padding:
                        const EdgeInsets.only(bottom: 25, left: 25, top: 70),
                    child: Image.asset(
                      "images/Groupe 1@2x.png",
                    )),
                const SizedBox(
                  height: 200,
                ),
                Container(
                  padding: const EdgeInsets.all(0.0),
                  child: const Text(
                    "Félicitation",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Bienvenue chez vous !",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ));
  }

  void sign() async {
    var reponse = await http.post(Uri.parse("${constance.urlApi}login"),
        body: ({'phone': telephone, 'password': password}));

    if (reponse.statusCode == 200) {
      var resp = json.decode(reponse.body);

      var response = resp["response"].toString();
      var message = resp["message"];

      if (response == 'SUCCESS') {
        var accessToken = resp["access_token"];
        var tokenType = resp["token_type"];

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${message}")));

        pageRoute(accessToken, tokenType);
      } else if (response == 'ERREUR') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${message}")));
      }
    } else {
      var resp = json.decode(reponse.body);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${resp["message"]}")));
    }
  }

  void pageRoute(String accessToken, String tokenType) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("access_token", accessToken);
    await pref.setString("token_type", tokenType);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home_screen()),
        (route) => false);
  }
}
