import 'dart:convert';

import 'package:ahio/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:ahio/common/constance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class securityProfil extends StatefulWidget {
  const securityProfil({super.key});

  @override
  State<securityProfil> createState() => _securityProfilState();
}

class _securityProfilState extends State<securityProfil> {
  final _formkey = GlobalKey<FormState>();

  final _snackBar = const SnackBar(
    content: Text('Tous les champs sont obligatoires'),
    backgroundColor: Colors.red,
  );

  late String token, nom, telephone, mail, type = "";
  var name, phone, email;

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("access_token")!;
      nom = pref.getString("nom")!;
      telephone = pref.getString("phone")!;
      mail = pref.getString("email")!;
      type = pref.getString("token_type")!;

      name = TextEditingController(text: nom);
      phone = TextEditingController(text: telephone);
      email = TextEditingController(text: mail);
    });
  }

  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: couleurTransparant,
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
      backgroundColor: couleurFond,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.lock_outlined,
                  size: 30,
                ),
                Text(
                  'Confidentialité et sécurité',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Gap(100),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Changer de mot de passe',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: name,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Mot de passe",
                              prefixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Ancien :",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              suffixIcon: Container(
                                margin: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFBDBDBD),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.drive_file_rename_outline_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veillez entrer votre mot de passe actuel";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: phone,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Mot de passe",
                              prefixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Nouveau :",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              suffixIcon: Container(
                                margin: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFBDBDBD),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.drive_file_rename_outline_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez entrer votre nouveau mot de passe";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: email,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Mot de passe",
                              prefixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Confirmer \nnouveau :",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              suffixIcon: Container(
                                margin: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFBDBDBD),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.drive_file_rename_outline_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veillez entrer confirmer votre nouveau mot de passe";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const Gap(20),
                          const Text(
                            "Mot de passe oublié ?",
                            style: TextStyle(
                              color: Color.fromRGBO(106, 196, 0, 1),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          SizedBox(
                            width: 70.0.w,
                            height: 6.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("#93E237"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  register();
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(_snackBar);
                                }
                              },
                              child: Text(
                                "Modifier",
                                style: TextStyle(
                                    fontSize: 6.w,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void register() async {
    var reponse = await http.post(
        Uri.parse(
          "${constance.urlApi}updateProfil",
        ),
        body: ({
          'name': name.text,
          'email': email.text,
          'phone': phone.text,
          'password': password.text
        }),
        headers: {
          'Authorization': '$type $token',
        });

    print(reponse.statusCode);

    if (reponse.statusCode == 200) {
      var resp = json.decode(reponse.body);

      var response = resp["response"];
      var message = resp["message"];

      if (response == 'SUCCESS') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${message}")));

        //pageRoute(phone.text, password.text);
      } else if (response == 'ERREUR') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${resp["object"]}")));
      }
    } else {
      var resp = json.decode(reponse.body);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${resp["message"]}")));
    }
  }
/**
    void pageRoute(String phone, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("phone", phone);
    await pref.setString("passwword", password);
    }*/
}
