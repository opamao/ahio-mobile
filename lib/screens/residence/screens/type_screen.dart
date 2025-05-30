import 'dart:convert';

import 'package:ahio/constants/api_url.dart';
import 'package:ahio/screens/locator/screens/lacator_screen.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../models/client/list_type_residence_model.dart';
import '../../../widgets/widgets.dart';

class TypeScreen extends StatefulWidget {
  const TypeScreen({super.key});

  @override
  State<TypeScreen> createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  String selected = "";
  String libelle = "";

  late Future<List<ListResidenceModel>> _residenceFuture;

  @override
  void initState() {
    super.initState();
    _residenceFuture = fetchResidence();
  }

  Future<List<ListResidenceModel>> fetchResidence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? accessToken = pref.getString("access_token");

    final http.Response response = await http.get(
      Uri.parse(ApiUrls.getListTypeResidence),
      headers: {
        'Authorization': "Bearer $accessToken",
      },
    );

    debugPrint(response.body.toString(), wrapWidth: 1024);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final List<dynamic> dataList = jsonResponse['data'];

      List<ListResidenceModel> listType =
          dataList.map((item) => ListResidenceModel.fromJson(item)).toList();

      return listType;
    } else {
      throw Exception(
          "Une erreur s'est produite lors de la requête HTTP: ${response.statusCode}");
    }
  }

  Widget customRadio(String titre, String index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selected = index;
          libelle = titre;
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: (selected == index)
            ? Colors.transparent
            : const Color.fromRGBO(21, 22, 21, 0.3),
        foregroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(
            color: (selected == index)
                ? const Color.fromRGBO(147, 226, 55, 1)
                : const Color.fromRGBO(21, 22, 21, 0.0),
            width: 3.0),
      ),
      child: Row(
        children: [
          /*Image.network(
            image,
            height: 100,
            width: 100,
          ),*/
          Text(
            titre.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 239, 216, 1.0),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      body: SafeArea(
        child: Hero(
          tag: 'type',
          child: Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              children: [
                Text(
                  "Quel est le type de Résidence disposez-vous ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: FutureBuilder<List<ListResidenceModel>>(
                    future: _residenceFuture,
                    builder: (context,
                        AsyncSnapshot<List<ListResidenceModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return Center(
                          child: Text('Erreur: ${snapshot.error}'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final ListResidenceModel type =
                                snapshot.data![index];
                            return Container(
                              padding: const EdgeInsets.all(5),
                              child: customRadio(
                                //type.image!,
                                type.name!,
                                type.id!,
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                SubmitButton(
                  "Suivant",
                  onPressed: () {
                    if (libelle == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Veuillez un type de résidence"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Maps(type: selected),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
