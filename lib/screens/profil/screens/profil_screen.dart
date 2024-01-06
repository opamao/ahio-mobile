import 'package:ahio/constants/constants.dart';
import 'package:ahio/screens/login/screens/login_screen.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../profil.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String nom = "";

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nom = pref.getString("nom")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 250, 230),
      body: Column(
        children: [
          const Expanded(
            flex: -5,
            child: _TopPortion(),
          ),
          Expanded(
            child:
                Padding(padding: const EdgeInsets.all(5.0), child: _autres()),
          ),
        ],
      ),
    );
  }
}

class _autres extends StatefulWidget {
  @override
  State<_autres> createState() => _autresState();
}

class _autresState extends State<_autres> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfilScreen(),
              ),
            );
          },
          dense: true,
          leading: const Icon(Icons.person_outline_rounded),
          title: const Text(
            'Informations personnelles',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(
          thickness: 2,
          indent: 20,
          endIndent: 20,
          height: 2,
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecurityProfilScreen(),
              ),
            );
          },
          leading: const Icon(Icons.lock_outlined),
          title: const Text(
            "Confidentialité et sécurité",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          dense: true,
        ),
        // const Divider(
        //   thickness: 2,
        //   indent: 20,
        //   endIndent: 20,
        //   height: 2,
        // ),
        // ListTile(
        //   onTap: () {},
        //   leading: const Icon(Icons.translate_outlined),
        //   title: const Text(
        //     "Langues",
        //     style: TextStyle(
        //       fontSize: 14,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        //   dense: true,
        // ),
        // const Divider(
        //   thickness: 2,
        //   indent: 20,
        //   endIndent: 20,
        //   height: 2,
        // ),
        // ListTile(
        //   onTap: () {},
        //   leading: const Icon(Icons.notifications_outlined),
        //   title: const Text(
        //     "Notifications",
        //     style: TextStyle(
        //       fontSize: 14,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        //   dense: true,
        // ),
        // const Divider(
        //   thickness: 2,
        //   indent: 20,
        //   endIndent: 20,
        //   height: 2,
        // ),
        // ListTile(
        //   onTap: () {},
        //   leading: const Icon(Icons.exit_to_app_rounded),
        //   title: const Text(
        //     "Mode sombre",
        //     style: TextStyle(
        //       fontSize: 14,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        //   dense: true,
        // ),
        const Divider(),
        ListTile(
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'DECONNEXION',
                style: TextStyle(color: Colors.red),
              ),
              content: const Text('Êtes-vous sûr ?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text(
                    'NON',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    logout();
                  },
                  child: const Text(
                    'OUI',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
          leading: const Icon(
            Icons.exit_to_app_rounded,
            color: Colors.red,
          ),
          title: const Text(
            "Se déconnecter",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          dense: true,
        ),
      ],
    );
  }

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String typeToken = pref.getString("token_type")!;
    String token = pref.getString("access_token")!;

    print(typeToken + ' ' + token);

    var reponse = await http.post(
        Uri.parse(
          "${ApiUrls.urlApi}logout",
        ),
        headers: {
          'Authorization': "$typeToken $token",
        });

    print(reponse.statusCode);

    if (reponse.statusCode == 200) {
      var resp = json.decode(reponse.body);

      print(resp);

      var response = resp["response"];
      var message = resp["message"];

      if (response == 'SUCCESS') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("$message")));

        pageRoute();
      } else if (response == 'ERREUR') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Une erreur s'est produite, veuillez ressayer")));
      }
    } else {
      var resp = json.decode(reponse.body);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${resp["message"]}")));
    }
  }

  void pageRoute() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
  }
}

class _TopPortion extends StatefulWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  State<_TopPortion> createState() => _TopPortionState();
}

class _TopPortionState extends State<_TopPortion> {
  String nom = "";

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nom = pref.getString("nom")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Profil",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 42,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 90,
              height: 90,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("images/ahio.png"),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Nom utilisateur",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            nom,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
