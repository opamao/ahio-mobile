import 'package:ahio/screens/home/screens/home_screen.dart';
import 'package:ahio/screens/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SplashScreenn extends StatelessWidget {
  const SplashScreenn({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset("images/ahionoir.png"),
      duration: 3000,
      backgroundColor: const Color.fromRGBO(147, 226, 55, 1),
      nextScreen: const TestScreen(),
    );
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    checkLogin();
    _pageController = PageController(initialPage: 0);
    _nbreSlides = demoData.length;
    super.initState();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("access_token");
    if (val != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    }
  }

  late PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _pageIndex = 0;
  late int _nbreSlides;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(147, 226, 55, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: demoData.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => TestScreenContent(
                    logo: demoData[index].logo,
                    image: demoData[index].image,
                    titre: demoData[index].titre,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    demoData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    shape: const CircleBorder(),
                    onPressed: () {
                      if (_pageIndex + 1 == _nbreSlides) {
                        // passer au login
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                        return;
                      }
                      _pageController.nextPage(
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.black87,
                      size: 20.sp,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TestScreenContent extends StatelessWidget {
  const TestScreenContent({
    Key? key,
    required this.logo,
    required this.image,
    required this.titre,
  }) : super(key: key);

  final String logo, image, titre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(147, 226, 55, 1),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 250),
              child: Image.asset(logo),
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 40, right: 55),
              child: Image.asset(
                image,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              titre,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 29,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class Onboard {
  final String logo, image, titre;

  Onboard({
    required this.logo,
    required this.image,
    required this.titre,
  });
}

final List<Onboard> demoData = [
  Onboard(
      logo: "images/ahionoir.png",
      image: "images/fleur.png",
      titre: "Trouve la\nrésidence qui \nqui vous ressemble"),
  Onboard(
      logo: "images/ahionoir.png",
      image: "images/femme3.png",
      titre: "Faites du business,\nc'est simple et \ntransparent")
];

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: isActive ? 3.w : 2.w,
      width: 5.w,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white54,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
