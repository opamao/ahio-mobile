import 'dart:convert';

import 'dart:ffi';
import 'dart:ui';
import 'package:ahio/common/constance.dart';
import 'package:ahio/common/input/input_password.dart';
import 'package:ahio/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ahio/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class Changepass extends StatefulWidget {
  const Changepass({super.key});

  @override
  State<Changepass> createState() => _ChangepassState();
}

class _ChangepassState extends State<Changepass> {
  final _formkey = GlobalKey<FormState>();

  String? phone;

  @override
  void initState() {
    super.initState();
    getotp();
  }

  void getotp() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      phone = pref.getString("phone");
    });
  }

  List<String> option = ['proprietaire', 'client'];

  bool _obscure = true;
  bool _obscure1 = true;
  var password = TextEditingController();
  var confirmpassword = TextEditingController();

  final _snackBar = const SnackBar(
    content: Text('Les mots de passe ne correspondent pas '),
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.fond.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Assets.images.ahio1.image(
                          width: 20.w,
                          height: 20.w,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.w),
                          topRight: Radius.circular(10.w),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.7),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, top: 15, bottom: 10),
                                    child: const Column(
                                      children: [
                                        Text(
                                          "Creation de mot de passe ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Entrer votre nouveau mot de passe ",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 35, right: 35),
                                      child: Form(
                                        key: _formkey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            InputPassword(
                                              controller: password,
                                              hintText: "Nouveau mot de passe",
                                              prefixIcon: const Padding(
                                                padding: EdgeInsets.all(0),
                                                child: Icon(Icons.lock),
                                              ),
                                              validatorMessage:
                                                  "Votre mot de passe doit être de 8 caractères",
                                              suffixIcon: IconButton(
                                                  icon: Icon(_obscure
                                                      ? Icons.visibility
                                                      : Icons.visibility_off),
                                                  onPressed: () {
                                                    setState(() {
                                                      _obscure = !_obscure;
                                                    });
                                                  }),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InputPassword(
                                              controller: confirmpassword,
                                              hintText:
                                                  "Confirmer le mot de passe",
                                              prefixIcon: const Padding(
                                                padding: EdgeInsets.all(0),
                                                child: Icon(Icons.lock),
                                              ),
                                              validatorMessage:
                                                  "Votre mot de passe doit être de 8 caractères",
                                              suffixIcon: IconButton(
                                                  icon: Icon(_obscure
                                                      ? Icons.visibility
                                                      : Icons.visibility_off),
                                                  onPressed: () {
                                                    setState(() {
                                                      _obscure = !_obscure;
                                                    });
                                                  }),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            SizedBox(
                                              width: 300.0,
                                              height: 50.0,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      HexColor("#93E237"),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  if (_formkey.currentState!
                                                      .validate()) {
                                                    if (confirmpassword.text ==
                                                        password.text) {
                                                      changemdp();
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              _snackBar);
                                                    }
                                                  }
                                                },
                                                child: const Text(
                                                  "Continuer",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 163,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void changemdp() async {
    var reponse = await http.post(
        Uri.parse("${constance.urlApi}changePassword/${phone}"),
        body: ({'password': password.text}));

    print(reponse.statusCode);

    if (reponse.statusCode == 200) {
      var resp = json.decode(reponse.body);

      var response = resp["response"].toString();

      if (response == 'SUCCESS') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Votre mot de passe a ete modifie")));

        pageRoute();
      } else if (response == 'ERREUR') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Mot de passe non modifie, ressayez")));
      }
    } else {
      var resp = json.decode(reponse.body);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Erreur, ressayez")));
    }
  }

  void pageRoute() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
  }
}
