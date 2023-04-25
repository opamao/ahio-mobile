import 'package:ahio/home/profil/profil_screen.dart';
import 'package:ahio/home/residence/capacite_screen.dart';
import 'package:ahio/home/residence/equipement_screen.dart';
import 'package:ahio/homeApbar.dart';
import 'package:ahio/home_screen.dart';
import 'package:ahio/password/otp.dart';
import 'package:ahio/password/recuppassword.dart';
import 'package:flutter/material.dart';
import 'package:ahio/login.dart';
import 'package:sizer/sizer.dart';
import 'splash_screen.dart';
import 'felicitation.dart';
import 'inscription.dart';
import 'lacator.dart';
import 'package:ahio/password/changepassword.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          initialRoute: "/home_screen",
          routes: {
            '/login': (context) => const Login(),
            '/splash_screen': (context) => const SplashScreenn(),
            '/felicitation': (context) => const Felicitation(),
            '/recuppassword': (context) => const recuppassword(),
            '/home_screen': (context) => const Home_screen(),
            '/homeApbar': (context) => const HomeApbar(),
            '/otp': (context) => const Otp(),
            '/locator': (context) => const Maps(),
            '/inscription': (context) => const Inscription(),
            '/changepass': (context) => const Changepass(),
            '/capacite': (context) => const CapaciteScreen(),
            '/equipement': (context) => const EquipementScreen(),
            '/profil': (context) => const ProfilScreen(),
            // '/login': (context) => Login(),
          },
        );
      },
    );
  }
}
