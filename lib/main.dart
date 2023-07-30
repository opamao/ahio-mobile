import 'package:ahio/home/paiement/mode_paiement.dart';
import 'package:ahio/home/profil/profil_screen.dart';
import 'package:ahio/home/residence/capacite_screen.dart';
import 'package:ahio/home/residence/equipement_screen.dart';
import 'package:ahio/homeApbar.dart';
import 'package:ahio/home_screen.dart';
import 'package:ahio/load.dart';
import 'package:ahio/page_not_found.dart';
import 'package:ahio/password/otp.dart';
import 'package:ahio/password/recuppassword.dart';
import 'package:ahio/route.dart';
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
            useMaterial3: true,
          ),
          home: const SplashScreenn(),
          onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        );
      },
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreenn(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
      case Routes.felicitation:
        return MaterialPageRoute(
          builder: (context) => const Felicitation(),
        );
      case Routes.recuppassword:
        return MaterialPageRoute(
          builder: (context) => const recuppassword(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const Home_screen(),
        );
      case Routes.homeApbar:
        return MaterialPageRoute(
          builder: (context) => const HomeApbar(),
        );
      case Routes.otp:
        return MaterialPageRoute(
          builder: (context) => const Otp(),
        );
      case Routes.locator:
        return MaterialPageRoute(
          builder: (context) => const Maps(),
        );
      case Routes.inscription:
        return MaterialPageRoute(
          builder: (context) => const Inscription(),
        );
      case Routes.changepass:
        return MaterialPageRoute(
          builder: (context) => const Changepass(),
        );
      case Routes.capacite:
        return MaterialPageRoute(
          builder: (context) => const CapaciteScreen(),
        );
      case Routes.equipement:
        return MaterialPageRoute(
          builder: (context) => const EquipementScreen(),
        );
      case Routes.profil:
        return MaterialPageRoute(
          builder: (context) => const ProfilScreen(),
        );
      case Routes.paiement:
        return MaterialPageRoute(
          builder: (context) => const ModePaiementScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const PageNotFoundScreen(),
        );
    }
  }
}
