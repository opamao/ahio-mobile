import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:ahio/common/constance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfil extends StatefulWidget {
  const EditProfil({super.key});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  final _formkey = GlobalKey<FormState>();

  bool _obscure = true;

  final _snackBar = const SnackBar(
    content: Text('Tous les champs sauf le email sont obligatoires'),
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/fond.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(0, 141, 249, 83),
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
          backgroundColor: const Color.fromARGB(0, 146, 240, 95),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.only(right: 220, top: 90),
                  child: Image.asset(
                    "images/ahio1.png",
                    width: 20.w,
                    height: 10.h,
                  )),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.96),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: Text(
                              "MODIFICATION",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              child: Form(
                                  key: _formkey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: name,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          hintText: "Nom complet",
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Icon(Icons.person),
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Veillez entrer un nom correct";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        controller: phone,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          hintText: "Téléphone",
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Icon(Icons.phone),
                                          ),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r"[0-9]"))
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length != 10) {
                                            return "Votre numéro doit être de 10 chiffres";
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
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          hintText: "Email",
                                          prefixIcon: const Icon(Icons.email),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: password,
                                        textInputAction: TextInputAction.done,
                                        obscureText: _obscure,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          hintText: "Mot de passe",
                                          suffixIcon: IconButton(
                                              icon: Icon(_obscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                              onPressed: () {
                                                setState(() {
                                                  _obscure = !_obscure;
                                                });
                                              }),
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Icon(Icons.lock),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty
                                              // !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                              //     .hasMatch(value)
                                              ) {
                                            return "Votre mot de passe doit être de 8 caractères";
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 10.w,
                                      ),
                                      SizedBox(
                                        width: 70.0.w,
                                        height: 6.h,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  HexColor("#93E237"),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (_formkey.currentState!
                                                  .validate()) {
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
                                            )),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          )),
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
