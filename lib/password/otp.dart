import 'dart:convert';
import 'dart:ui';
import 'package:ahio/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'changepassword.dart';
import 'package:http/http.dart' as http;
import 'package:ahio/common/constance.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _otpState();
}

class _otpState extends State<Otp> {
  final _formkey = GlobalKey<FormState>();

  final _fieldOne = TextEditingController();
  final _fieldTwo = TextEditingController();
  final _fieldThree = TextEditingController();
  final _fieldFour = TextEditingController();
  final _fieldFive = TextEditingController();

  String? telephone;

  @override
  void initState() {
    super.initState();
    getotp();
  }

  void getotp() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      telephone = pref.getString("phone");
    });
  }

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
                                    left: 5, top: 25, bottom: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      " vérification du numéro ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      " de téléphone",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Entrez le code reçu par mail ou sms ",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                margin:
                                    const EdgeInsets.only(left: 35, right: 35),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    OtpInput(_fieldOne, false),
                                    // auto focus
                                    OtpInput(_fieldTwo, false),
                                    OtpInput(_fieldThree, false),
                                    OtpInput(_fieldFour, false),
                                    OtpInput(_fieldFive, false)
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
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
                                    onPressed: () {
                                      verifotp();
                                    },
                                    child: const Text(
                                      "Continuer",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void verifotp() async {
    print(telephone);
    print("ICI OH");
    var reponse = await http.post(
        Uri.parse("${constance.urlApi}verificationCodeOtp/${telephone}"),
        body: ({
          'code_otp': (_fieldOne.text +
                  _fieldTwo.text +
                  _fieldThree.text +
                  _fieldFour.text +
                  _fieldFive.text)
              .toString()
        }));

    print(reponse.statusCode);

    if (reponse.statusCode == 200) {
      var resp = json.decode(reponse.body);

      var response = resp["response"].toString();

      if (response == 'SUCCESS') {
        var object = resp["object"];

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("code valide")));

        pageRoute(object);
      } else if (response == 'ERREUR') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("code non validé veillez reessayer")));
      }
    } else {
      var resp = json.decode(reponse.body);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erreur, veuillez ressayer")));
    }
  }

  void pageRoute(String object) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("phone", object);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Changepass()),
        (route) => false);
  }
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;

  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
