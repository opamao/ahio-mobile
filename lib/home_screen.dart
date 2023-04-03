import 'package:ahio/home/accueil/accueil_screen.dart';
import 'package:ahio/home/favoris/favoris_screen.dart';
import 'package:ahio/home/location/location_screen.dart';
import 'package:ahio/home/profil/profil_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {

  int selectedIndex = 0;
  final Widget _accueil = const AccueilScreen();
  final Widget _favoris = const FavorisScreen();
  final Widget _location = const LocationsScreen();
  final Widget _profil = const ProfilScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.getBody(),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: this.selectedIndex,
        items: [
          SalomonBottomBarItem(
            icon: Image.asset("images/accueilIcon.png"),
            title: const Text("Accueil",
                style: TextStyle(color: Colors.black, fontSize: 12)),
            selectedColor: const Color.fromRGBO(18, 140, 126, 1),
          ),
          SalomonBottomBarItem(
            icon: Image.asset("images/favorisIcon.png"),
            title: const Text("Favoris",
                style: TextStyle(color: Colors.black, fontSize: 12)),
            selectedColor: const Color.fromRGBO(18, 140, 126, 1),
          ),
          SalomonBottomBarItem(
            icon: Image.asset("images/locationIcon.png"),
            title: const Text("Location",
                style: TextStyle(color: Colors.black, fontSize: 12)),
            selectedColor: const Color.fromRGBO(18, 140, 126, 1),
          ),
          SalomonBottomBarItem(
            icon: Image.asset("images/profilIcon.png"),
            title: const Text("Profil",
                style: TextStyle(color: Colors.black, fontSize: 12)),
            selectedColor: const Color.fromRGBO(18, 140, 126, 1),
          )
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody() {
    if (this.selectedIndex == 0) {
      return this._accueil;
    } else if (this.selectedIndex == 1) {
      return this._favoris;
    } else if (this.selectedIndex == 2) {
      return this._location;
    } else {
      return this._profil;
    }
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}
