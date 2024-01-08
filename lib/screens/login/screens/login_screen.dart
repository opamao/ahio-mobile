import 'dart:convert';
import 'dart:ui';

import 'package:ahio/constants/constants.dart';
import 'package:ahio/screens/inscription/screens/inscription_screen.dart';
import 'package:ahio/screens/loading/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../../gen/assets.gen.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';
import '../../password/password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();

  bool showPhoneField = false;
  bool _obscure = true;

  var email = TextEditingController();
  var password = TextEditingController();

  final _snackBar = const SnackBar(
    content: Text('Tous les champs sont obligatoires'),
    backgroundColor: Colors.red,
  );

  String phoneInicator = "";
  String initialCountry = 'CI';
  PhoneNumber number = PhoneNumber(isoCode: 'CI');

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
                                        if (showPhoneField)
                                          Container(
                                            padding: EdgeInsets.only(left: 4.w),
                                            decoration: BoxDecoration(
                                                color: colorWhite,
                                                borderRadius:
                                                    BorderRadius.circular(4.w),
                                                border: Border.all()),
                                            child:
                                                InternationalPhoneNumberInput(
                                              onInputChanged:
                                                  (PhoneNumber number) {
                                                print(number.phoneNumber);
                                                phoneInicator =
                                                    number.phoneNumber!;
                                              },
                                              onInputValidated: (bool value) {
                                                print(value);
                                              },
                                              errorMessage:
                                                  "Le numéro est invalide",
                                              hintText: "Numéro de téléphone",
                                              selectorConfig:
                                                  const SelectorConfig(
                                                selectorType:
                                                    PhoneInputSelectorType
                                                        .BOTTOM_SHEET,
                                              ),
                                              ignoreBlank: false,
                                              autoValidateMode:
                                                  AutovalidateMode.disabled,
                                              selectorTextStyle:
                                                  const TextStyle(
                                                color: Colors.black,
                                              ),
                                              initialValue: number,
                                              textFieldController: email,
                                              formatInput: true,
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                signed: true,
                                                decimal: true,
                                              ),
                                              inputBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                              onSaved: (PhoneNumber number) {
                                                print('On Saved: $number');
                                              },
                                            ),
                                          ),
                                        if (!showPhoneField)
                                          InputText(
                                            keyboardType: TextInputType.text,
                                            controller: email,
                                            hintText: "Adresse email",
                                            prefixIcon: const Padding(
                                              padding: EdgeInsets.all(0),
                                              child: Icon(Icons.email),
                                            ),
                                            validatorMessage:
                                                "Veuillez saisir votre téléphone ou mail",
                                          ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              showPhoneField = !showPhoneField;
                                            });
                                          },
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              !showPhoneField
                                                  ? "Connecter par téléphone"
                                                  : "Retour à l'adresse email",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: colorBlack,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
                                              ), // Change to your color
                                            ),
                                          ),
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

  void sign() async {
    Map<String, String> requestBody = {
      'phone': phoneInicator.isEmpty ? email.text : phoneInicator,
      'password': password.text,
    };

    var response = await http.post(
      Uri.parse("${ApiUrls.urlApi}login"),
      body: requestBody,
    );

    var resp = json.decode(response.body);

    print(resp);

    if (response.statusCode == 200) {
      var response = resp["response"].toString();
      var message = resp["message"];

      if (response == 'SUCCESS') {
        var accessToken = resp["object"]["access_token"];
        var tokenType = resp["object"]["token_type"];
        var name = resp["object"]["name"];
        var email = resp["object"]["email"] ?? "";
        var phone = resp["object"]["phone"];
        var role = resp["object"]["role_as"].toString();
        var id = resp["object"]["id"].toString();
        var mobileMoney = resp["object"]["phone_mobile_money"] ?? "";
        var photo = resp["object"]["photo_identity"] ?? "";
        var piece = resp["object"]["piece_identity"] ?? "";
        var activation = resp["object"]["is_active"].toString();
        var proprietaireId = resp["object"]["proprietaire_id"].toString();
        var garantId = resp["object"]["gerant_id"].toString();

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("$message")));

        pageRoute(accessToken, tokenType, name, email, phone, role, id,
            mobileMoney, photo, piece, activation, proprietaireId, garantId);
      } else if (response == 'ERREUR') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("$message")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${resp["message"]}")));
    }
  }

  void pageRoute(
    String accessToken,
    String tokenType,
    String name,
    String email,
    String phone,
    String role,
    String id,
    String mobileMoney,
    String photo,
    String piece,
    String activation,
    String proprietaireId,
    String garantId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("access_token", accessToken);
    await pref.setString("token_type", tokenType);
    await pref.setString("nom", name);
    await pref.setString("email", email);
    await pref.setString("phone", phone);
    await pref.setString("role", role);
    await pref.setString("id", id);
    await pref.setString("mobile_money", mobileMoney);
    await pref.setString("photo", photo);
    await pref.setString("piece", piece);
    await pref.setString("activation", activation);
    await pref.setString("proprietaire_id", proprietaireId);
    await pref.setString("garant_id", garantId);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Loading()),
        (route) => false);
  }
}
