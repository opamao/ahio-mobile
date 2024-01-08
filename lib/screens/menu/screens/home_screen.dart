import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../accueil/accueil.dart';
import '../../favoris/favoris.dart';
import '../../location/location.dart';
import '../../profil/profil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;
  final Widget _accueil = AccueilScreen();

  final Widget _favoris = const FavorisScreen();
  final Widget _location = const LocationsScreen();
  final Widget _profil = const ProfilScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: selectedIndex,
        items: [
          SalomonBottomBarItem(
            icon: Image.asset("images/accueilIcon.png"),
            title: const Text(
              "Accueil",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            selectedColor: const Color.fromRGBO(18, 140, 126, 1),
          ),
          SalomonBottomBarItem(
            icon: Image.asset("images/favorisIcon.png"),
            title: const Text(
              "Favoris",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            selectedColor: const Color.fromRGBO(18, 140, 126, 1),
          ),
          SalomonBottomBarItem(
            icon: Image.asset("images/locationIcon.png"),
            title: const Text(
              "Location",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            selectedColor: const Color.fromRGBO(18, 140, 126, 1),
          ),
          SalomonBottomBarItem(
            icon: Image.asset("images/profilIcon.png"),
            title: const Text(
              "Profil",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            selectedColor: const Color.fromRGBO(18, 140, 126, 1),
          )
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return _accueil;
    } else if (selectedIndex == 1) {
      return _favoris;
    } else if (selectedIndex == 2) {
      return _location;
    } else {
      return _profil;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
