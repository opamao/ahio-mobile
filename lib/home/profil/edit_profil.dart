import 'dart:convert';
import 'dart:io';

import 'package:ahio/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:ahio/common/constance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({super.key});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  final _formkey = GlobalKey<FormState>();

  bool _obscure = true;

  File? images;
  final picker = ImagePicker();

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

  Future imagepick() async {
    try {
      final _images =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_images == null) return;
      final imageTemp = File(images!.path);
      setState(() => this.images = imageTemp);
    } on PlatformException catch (e) {}
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
                  Icons.person_outline_rounded,
                  size: 30,
                ),
                Text(
                  'Informations personnelles',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 90,
              height: 90,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  images != null
                      ? ClipOval(
                          child: Image.file(
                            images!,
                            width: 20,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 3,
                              color: Colors.black,
                            ),
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("images/ahio.png"),
                            ),
                          ),
                        ),
                  Positioned(
                    top: 50,
                    left: 34,
                    child: IconButton(
                      icon: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        imagepick();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
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
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: "Nom utilisateur",
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Nom :",
                                      textAlign: TextAlign.center,
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
                                  return "Veillez entrer un nom utilisateur correct";
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
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: "Téléphone",
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Tel :",
                                      textAlign: TextAlign.center,
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
                                  return "Veuillez entrer un numéro de téléphone";
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
                                hintText: "Email utilisateur",
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "  Email :",
                                      textAlign: TextAlign.center,
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
