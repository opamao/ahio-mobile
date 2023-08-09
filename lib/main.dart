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
import 'home/residence/type_screen.dart';
import 'splash_screen.dart';
import 'felicitation.dart';
import 'inscription.dart';
import 'lacator.dart';
import 'package:ahio/password/changepassword.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        );
      },
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    print("=====================");
    print(args);

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
        {
          if (settings.name == '/locator') {
            // Récupérer les arguments de la route
            Map<String, dynamic>? arguments =
                settings.arguments as Map<String, dynamic>?;

            // Vérifier si les arguments contiennent la clé "type"
            if (arguments != null && arguments.containsKey('type')) {
              // Récupérer la valeur associée à la clé "type"
              String type = arguments['type'];

              // Retourner la page correspondant à "/locator" avec les arguments
              return MaterialPageRoute(
                builder: (context) => Maps(type: type),
              );
            }
          }
          return MaterialPageRoute(
            builder: (context) => TypeScreen(),
          );
        }

      case Routes.inscription:
        return MaterialPageRoute(
          builder: (context) => const Inscription(),
        );
      case Routes.changepass:
        return MaterialPageRoute(
          builder: (context) => const Changepass(),
        );
      case Routes.capacite:
        {
          if (settings.name == '/capacite') {
            // Récupérer les arguments de la route
            Map<String, dynamic>? arguments =
                settings.arguments as Map<String, dynamic>?;

            // Vérifier si les arguments contiennent la clé "type"
            if (arguments != null && arguments.containsKey('type')) {
              // Récupérer la valeur associée à la clé "type"
              String type = arguments['type'];
              String adresse = arguments['adresse'];
              String quartier = arguments['quartier'];
              String rue = arguments['rue'];
              int pays = arguments['pays'];
              int ville = arguments['ville'];

              // Retourner la page correspondant à "/capacite" avec les arguments
              return MaterialPageRoute(
                builder: (context) => CapaciteScreen(
                  adresse: adresse,
                  quartier: quartier,
                  rue: rue,
                  type: type,
                  pays: pays,
                  ville: ville,
                ),
              );
            }
          }
        }
        break;
      case Routes.equipement:
        return MaterialPageRoute(
          builder: (context) => const EquipementScreen(),
        );
      case Routes.profil:
        return MaterialPageRoute(
          builder: (context) => ProfilScreen(),
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
