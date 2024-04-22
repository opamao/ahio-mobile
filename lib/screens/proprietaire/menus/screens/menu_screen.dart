import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../accueil/accueil.dart';
import '../../gains/gains.dart';
import '../../profil/profil.dart';
import '../../residences/residences.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  int selectedIndex = 0;

  final Widget _accueil = const AccueilProprioScreen();
  final Widget _gains = const GainsScreen();
  final Widget _residences = const ResidencesScreen();
  final Widget _profile = const ProfileScreen();

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
              "Mes gains",
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
              "Mes résidences",
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
      return _gains;
    } else if (selectedIndex == 2) {
      return _residences;
    } else {
      return _profile;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
