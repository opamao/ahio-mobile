import 'package:ahio/home/profil/edit_profil.dart';
import 'package:ahio/login.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ahio/common/constance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
      backgroundColor: const Color.fromRGBO(225, 239, 216, 1.0),
      body: Column(
        children: [
          const Expanded(flex: 1, child: _TopPortion()),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    nom,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfil()));
                          },
                          label: const Text(
                            "Modifier",
                            style: TextStyle(color: Colors.blue),
                          ),
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _ProfileInfoRow(),
                ],
              ),
            ),
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
        Card(
          child: ListTile(
            onTap: () {},
            dense: true,
            leading: const Icon(Icons.person_outline_rounded),
            title: const Text('Mes Agents'),
            trailing: const Icon(Icons.navigate_next),
          ),
        ),
        Card(
          child: ListTile(
            onTap: () {},
            leading: const Icon(Icons.notifications_none_rounded),
            title: const Text("Notifications"),
            trailing: const Icon(Icons.navigate_next),
            dense: true,
          ),
        ),
        Card(
          child: ListTile(
            onTap: () {},
            leading: const Icon(Icons.help_outline_rounded),
            title: const Text("Aides & Feedback"),
            trailing: const Icon(Icons.navigate_next),
            dense: true,
          ),
        ),
        Card(
          child: ListTile(
            onTap: () {},
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text("Apropos"),
            trailing: const Icon(Icons.navigate_next),
            dense: true,
          ),
        ),
        const Divider(),
        Card(
          child: ListTile(
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
                    child: const Text('NON', style: TextStyle(color: Colors.black),),
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
              style: TextStyle(color: Colors.red),
            ),
            trailing: const Icon(Icons.navigate_next, color: Colors.red),
            dense: true,
          ),
        ),
      ],
    );
  }

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String typeToken = pref.getString("token_type")!;
    String token = pref.getString("access_token")!;
    
    print(typeToken + ' '+ token);

    var reponse = await http.post(
        Uri.parse(
          "${constance.urlApi}logout",
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

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("$message")));

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
        MaterialPageRoute(builder: (context) => const Login()), (route) => false);
  }
}

class _ProfileInfoRow extends StatefulWidget {
  @override
  State<_ProfileInfoRow> createState() => _ProfileInfoRowState();
}

class _ProfileInfoRowState extends State<_ProfileInfoRow> {
  String phone = "";
  String email = "";
  String role = "";

  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      phone = pref.getString("phone")!;
      email = pref.getString("email")!;
      role = pref.getString("role")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        elevation: 5.0,
        child: Row(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    phone,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text("Téléphone", style: Theme.of(context).textTheme.bodySmall)
              ],
            )),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    email,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text("E-mail", style: Theme.of(context).textTheme.bodySmall)
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class _TopPortion extends StatefulWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  State<_TopPortion> createState() => _TopPortionState();
}

class _TopPortionState extends State<_TopPortion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text("dde"),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage("images/ahio.png")),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        )
      ],
    );
  }
}
