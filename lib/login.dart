import 'dart:convert';
import 'dart:ui';
import 'package:ahio/common/constance.dart';
import 'package:ahio/common/input/input.dart';
import 'package:ahio/common/theme.dart';
import 'package:ahio/home_screen.dart';
import 'package:ahio/inscription.dart';
import 'package:ahio/loading.dart';
import 'package:ahio/password/recuppassword.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'gen/assets.gen.dart';
import 'load.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("access_token");
    if (val != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home_screen()),
          (route) => false);
    }
  }

  final _formkey = GlobalKey<FormState>();

  bool _obscure = true;

  var email = TextEditingController();
  var password = TextEditingController();

  final _snackBar = const SnackBar(
    content: Text('Tous les champs sont obligatoires'),
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
                          padding: const EdgeInsets.all(15),
                          color: Colors.white.withOpacity(0.7),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 2.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Connexion",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
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
                                          keyboardType: TextInputType.text,
                                          controller: email,
                                          hintText: "adresse mail",
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Icon(Icons.email),
                                          ),
                                          validatorMessage:
                                              "Veuillez saisir votre téléphone ou mail",
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        InputPassword(
                                          controller: password,
                                          hintText: "Mot de passe",
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
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const recuppassword(),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            "Mot de passe oublié ?",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 11,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
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
                                                  sign();
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             Loading()));
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(_snackBar);
                                                  Clean();
                                                }
                                              },
                                              child: const Text(
                                                constance.login,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(constance.textCreate,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 11,
                                            )),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Card(
                                                color: HexColor("#151615")
                                                    .withOpacity(.0001),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const Inscription()));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                          height: 10),
                                                      Image.asset(
                                                        "images/envelop.png",
                                                        width: 38,
                                                        height: 15,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                color: HexColor("#151615")
                                                    .withOpacity(.0001),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (ctx) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                          "«ahio» souhaite utiliser facebook.com» pour  se       connecter",
                                                          style: TextStyle(
                                                              fontSize: 19),
                                                        ),
                                                        content: const Text(
                                                          "Cela permet à l’app et au site web d’échanger des informations vous concernant.",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop();
                                                            },
                                                            child: Container(),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                          height: 10),
                                                      Image.asset(
                                                        "images/fb.png",
                                                        width: 38,
                                                        height: 20,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                color: HexColor("#151615")
                                                    .withOpacity(.0001),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (ctx) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                          "«ahio» souhaite utiliser google.com» pour  se       connecter",
                                                          style: TextStyle(
                                                              fontSize: 19),
                                                        ),
                                                        content: const Text(
                                                          "Cela permet à l’app et au site web d’échanger des informations vous concernant.",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop();
                                                            },
                                                            child: Container(),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                          height: 10),
                                                      Image.asset(
                                                        "images/google.png",
                                                        width: 38,
                                                        height: 20,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
          ],
        ),
      ),
    );
  }

  void Clean() {
    password.clear();
    email.clear();
  }

  void sign() async {
    print(password.text);
    //call export data
    var reponse = await http.post(Uri.parse("${constance.urlApi}login"),
        body: ({'phone': email.text, 'password': password.text}));

    if (reponse.statusCode == 200) {
      var resp = json.decode(reponse.body);

      var response = resp["response"].toString();
      var message = resp["message"];

      if (response == 'SUCCESS') {
        var accessToken = resp["access_token"];
        var tokenType = resp["token_type"];
        var name = resp["object"]["name"];
        var email = resp["object"]["email"];
        var phone = resp["object"]["phone"];
        var role = resp["object"]["role_as"].toString();

        print(name + " " + email + " " + phone + " " + role);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("$message")));

        pageRoute(accessToken, tokenType, name, email, phone, role);
      } else if (response == 'ERREUR') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("$message")));
      }
    } else {
      var resp = json.decode(reponse.body);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${resp["message"]}")));
    }
  }

  void pageRoute(String accessToken, String tokenType, String name,
      String email, String phone, String role) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("access_token", accessToken);
    await pref.setString("token_type", tokenType);
    await pref.setString("nom", name);
    await pref.setString("email", email);
    await pref.setString("phone", phone);
    await pref.setString("role", role);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Loading()), (route) => false);
  }
}
