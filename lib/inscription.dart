import 'dart:convert';
import 'dart:ui';
import 'package:ahio/common/constance.dart';
import 'package:ahio/common/input/input.dart';
import 'package:ahio/home_screen.dart';
import 'package:ahio/load.dart';
import 'package:ahio/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

import 'splash_screen.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splash: Image.asset("images/ahionoir.png"),
        duration: 3000,
        backgroundColor: const Color.fromRGBO(147, 226, 55, 1),
        nextScreen: const Login(),
      ),
    );
  }
}

class _InscriptionState extends State<Inscription> {
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  List<String> role = ['proprietaire', 'client'];

  int? selectedOption;
  bool _obscure = true;
  var password = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  int selected = 0;
  String phoneInicator = "";

  final _snackBar = const SnackBar(
    content: Text("Vérifiez vos champs!"),
    backgroundColor: Colors.red,
  );

  Widget customRadio(String titre, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selected = index;
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor:
            (selected == index) ? Colors.transparent : HexColor("#93E237"),
        foregroundColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(
            color: (selected == index)
                ? const Color.fromRGBO(147, 226, 55, 1)
                : const Color.fromRGBO(21, 22, 21, 0.0),
            width: 3.0),
      ),
      child: Text(
        titre,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String initialCountry = 'CI';
  PhoneNumber number = PhoneNumber(isoCode: 'CI');

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
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Image.asset(
                  "images/ahio1.png",
                  width: 90,
                  height: 90,
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
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 2.h),
                          const Text(
                            "Inscription",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 35, right: 35),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InputText(
                                    controller: name,
                                    hintText: "Nom complet",
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Icon(Icons.person),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validatorMessage:
                                        "Veillez entrer un nom correct",
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InternationalPhoneNumberInput(
                                    onInputChanged: (PhoneNumber number) {
                                      print(number.phoneNumber);
                                      phoneInicator = number.phoneNumber!;
                                    },
                                    onInputValidated: (bool value) {
                                      print(value);
                                    },
                                    errorMessage: "Le numéro est invalide",
                                    hintText: "Numéro de téléphone",
                                    selectorConfig: const SelectorConfig(
                                      selectorType:
                                          PhoneInputSelectorType.BOTTOM_SHEET,
                                    ),
                                    ignoreBlank: false,
                                    autoValidateMode: AutovalidateMode.disabled,
                                    selectorTextStyle: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    initialValue: number,
                                    textFieldController: phone,
                                    formatInput: true,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      signed: true,
                                      decimal: true,
                                    ),
                                    inputBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    onSaved: (PhoneNumber number) {
                                      print('On Saved: $number');
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InputText(
                                    controller: email,
                                    hintText: "email",
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Icon(Icons.email),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validatorMessage: 'le mail est obligatoire',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InputPassword(
                                    controller: password,
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
                                    validatorMessage:
                                        'Votre mot de passe doit être de 8 caractères',
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Etes-vous?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: customRadio(
                                                    "Propriétaire", 1),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Container(
                                                child: customRadio("Client", 3),
                                              ),
                                            ),
                                          ]),
                                      const SizedBox(height: 8),
                                      InputText_(
                                        keyboardType: TextInputType.number,
                                        controller: mobile,
                                        hintText:
                                            "Si proprietaire, numéro mobile money",
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.all(0),
                                          child: Icon(Icons.phone),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      children: [
                                        const TextSpan(
                                          text: "si vous avez deja un compte",
                                        ),
                                        const WidgetSpan(
                                          child: SizedBox(width: 5),
                                        ),
                                        WidgetSpan(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()));
                                              // Navigator.pushReplacementNamed(
                                              //     context, '/login');
                                            },
                                            child: const Text(
                                              "connectez-vous",
                                              style: TextStyle(
                                                color: Colors.black,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 300.0,
                                    height: 50.0,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: HexColor("#93E237"),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_formkey.currentState!.validate()) {
                                          register();

                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             Loader()));
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             Login()));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(_snackBar);
                                        }
                                      },
                                      child: const Text(
                                        constance.register,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void register() async {
    print(selected.toString());
    print(phoneInicator);
    var reponse = await http.post(Uri.parse("${constance.urlApi}register"),
        body: ({
          'name': name.text,
          'email': email.text,
          'phone': phoneInicator,
          'password': password.text,
          'role_as': selected.toString(),
          'phone_mobile_money': mobile.text.toString()
        }));

    print(reponse.statusCode);

    if (reponse.statusCode == 200) {
      print("ICI");
      var resp = json.decode(reponse.body);

      var response = resp["response"];
      var message = resp["message"];

      print(resp);

      if (response == 'SUCCESS') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${message}")));

        pageRoute(phone.text, password.text);
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

  void pageRoute(String phone, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("phone", phone);
    await pref.setString("passwword", password);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Loader()),
        (route) => false);
  }
}
