import 'dart:convert';
import 'dart:ui';

import 'package:ahio/common/constance.dart';
import 'package:ahio/gen/assets.gen.dart';
import 'package:ahio/password/otp.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../common/input/input_text.dart';

class recuppassword extends StatefulWidget {
  const recuppassword({super.key});

  @override
  State<recuppassword> createState() => _recuppasswordState();
}

class _recuppasswordState extends State<recuppassword> {
  final _formkey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    checkpassword();
  }

  void checkpassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("access_token");
    if (val != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Otp()), (route) => false);
    }
  }

  TextEditingController phone = TextEditingController();

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
                                      topRight: Radius.circular(40))),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 5, top: 50, bottom: 10),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Gestion de mot de passe oublié",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Entrer votre numéro associé au compte ahio",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 35,
                                          right: 35,
                                        ),
                                        child: Form(
                                          key: _formkey,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              InputText(
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: phone,
                                                hintText:
                                                    "Téléphone ou adresse mail",
                                                prefixIcon: const Padding(
                                                  padding: EdgeInsets.all(0),
                                                  child: Icon(Icons.person),
                                                ),
                                                validatorMessage:
                                                    "Veuillez saisir votre téléphone ou mail",
                                              ),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              SizedBox(
                                                width: 300.0,
                                                height: 50.0,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        HexColor("#93E237"),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    if (_formkey.currentState!
                                                        .validate()) {
                                                      recupass();
                                                    } else {
                                                      print("erreur");
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
                                                height: 40,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void recupass() async {
    var reponse = await http.post(
        Uri.parse("${constance.urlApi}askToChangePassword"),
        body: ({'phone': phone.text}));
    print(reponse.statusCode);
    if (reponse.statusCode == 200) {
      var resp = json.decode(reponse.body);
      var response = resp["response"].toString();
      //var message = resp["message"];
      if (response == 'SUCCESS') {
        var phonee = phone.text;

        print(phonee);

        pageRoute(phonee);
      } else if (response == 'ERREUR') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Votre nuéero est incorrect, ressayez")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erreur, veuillez ressayer")));
    }
  }

  void pageRoute(String phonee) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("phone", phonee);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Otp()), (route) => false);
  }
}
