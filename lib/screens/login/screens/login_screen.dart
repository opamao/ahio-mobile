import 'dart:convert';
import 'dart:ui';

import 'package:ahio/constants/constants.dart';
import 'package:ahio/screens/inscription/screens/inscription_screen.dart';
import 'package:ahio/screens/loading/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import '../../../gen/assets.gen.dart';
import '../../../widgets/widgets.dart';
import '../../password/password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                                Gap(2.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Connexion",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
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
                                          keyboardType: TextInputType.text,
                                          controller: email,
                                          hintText: "adresse email",
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
                                                    const RecupPasswordScreen(),
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
                                        SubmitButton(
                                          Constants.login,
                                          onPressed: () async {
                                            if (_formkey.currentState!
                                                .validate()) {
                                              sign();
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(_snackBar);
                                              Clean();
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          Constants.textCreate,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        CancelButton(
                                          Constants.register,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                const Inscription(),
                                              ),
                                            );
                                          },
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
    var reponse = await http.post(Uri.parse("${ApiUrls.urlApi}login"),
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
        var id = resp["object"]["id"].toString();

        print(name + " " + email + " " + phone + " " + role);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("$message")));

        pageRoute(accessToken, tokenType, name, email, phone, role, id);
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
      String email, String phone, String role, String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("access_token", accessToken);
    await pref.setString("token_type", tokenType);
    await pref.setString("nom", name);
    await pref.setString("email", email);
    await pref.setString("phone", phone);
    await pref.setString("role", role);
    await pref.setString("id", id);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Loading()),
        (route) => false);
  }
}
