import 'package:ahio/gen/assets.gen.dart';
import 'package:ahio/home/accueil/detail_accueil.dart';
import 'package:ahio/home/residence/espace_screen.dart';
import 'package:ahio/homeApbar.dart';
import 'package:ahio/itemsWidget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class AccueilScreen extends StatefulWidget {
  AccueilScreen({super.key, required this.role});

  @override
  State<AccueilScreen> createState() => AccueilScreenContent();
  List<String> role;
}

class AccueilScreenContent extends State<AccueilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 250, 230),
      body: ListView(
        children: [
          const HomeApbar(),
          Container(
            padding: EdgeInsets.only(left: 8.w),
            child: Row(
              children: [
                Image.asset(
                  "images/image1.png",
                  width: 10.w,
                  height: 10.w,
                ),
                const Gap(10),
                Text(
                  "Les meilleurs\nrésidences sont ici !",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
              ],
            ),
          ),
          const Gap(15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.symmetric(horizontal: 18),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  height: 50.h,
                  width: 50.w,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintText: "Recherche rapide...",
                      hintStyle: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // if (widget.role == 'proprietaire') ...[
          SizedBox(
              height: 30.h,
              child: Stack(children: [
                Positioned(
                    top: 35,
                    left: 20,
                    child: Material(
                      child: Container(
                        height: 22.h,
                        width: 92.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.w),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: const Offset(-10.0, 10.0),
                              blurRadius: 20.0,
                              spreadRadius: 4.0,
                            )
                          ],
                        ),
                      ),
                    )),
                Positioned(
                  top: 0,
                  left: 30,
                  child: Card(
                    elevation: 50.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: Assets.images.home.provider(),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 45,
                    left: 180,
                    child: SizedBox(
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Text(
                              "Ajouter votre résidence",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Divider(color: Colors.blue, height: 40),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EspaceScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Démarrer maintenant >",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        )))
              ])),
          // ],
          // (widget.role == 'proprietaire')
          //     ? Container(
          //         color: Colors.white,
          //         margin: const EdgeInsets.only(left: 20),
          //         height: 40,
          //         width: 280,
          //         child: ListView(
          //           scrollDirection: Axis.horizontal,
          //           children: [
          //             TextButton(
          //               onPressed: () {},
          //               child: Text(
          //                 "Appartement",
          //                 style:
          //                     TextStyle(color: Colors.black26, fontSize: 10.sp),
          //               ),
          //             ),
          //             const SizedBox(
          //               width: 3,
          //             ),
          //             TextButton(
          //                 onPressed: () {},
          //                 child: Text(
          //                   "Villa",
          //                   style: TextStyle(
          //                       color: Colors.black26, fontSize: 10.sp),
          //                 )),
          //             const SizedBox(
          //               width: 3,
          //             ),
          //             TextButton(
          //                 onPressed: () {},
          //                 child: Text(
          //                   "Chambre",
          //                   style: TextStyle(
          //                       color: Colors.black26, fontSize: 10.sp),
          //                 )),
          //           ],
          //         ),
          //       )
          // :
          Gap(25),
          Container(
            color: Colors.white.withOpacity(0.4),
            margin: const EdgeInsets.only(left: 20),
            height: 40,
            width: 280,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Appartement",
                    style: TextStyle(color: Colors.black26, fontSize: 10.sp),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Villa",
                      style: TextStyle(color: Colors.black26, fontSize: 10.sp),
                    )),
                const SizedBox(
                  width: 3,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Chambre",
                      style: TextStyle(color: Colors.black26, fontSize: 10.sp),
                    )),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailAccueilScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: Image.asset(
                          "images/sal2.png",
                          height: 250,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 180, left: 35),
                      child: Text(
                        "Lorem ipsum dolor sit \namet, consetetur \nsadipscing elitr, sed.",
                        style: TextStyle(color: Colors.grey.withOpacity(1)),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: Image.asset(
                    "images/sal1.png",
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Image.asset(
                    "images/fleur.png",
                    height: 230,
                    width: 230,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(13.0),
            child: Text(
              "Près de chez vous",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(left: 29),
            height: 40,
            width: 280,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "Abidjan",
                      style: TextStyle(color: Colors.black26, fontSize: 11),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Assinie",
                    style: TextStyle(color: Colors.black26, fontSize: 11),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Dabou",
                    style: TextStyle(color: Colors.black26, fontSize: 11),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Grand-Bereby",
                    style: TextStyle(color: Colors.black26, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          const ItemsWidget()
        ],
      ),
    );
  }
}
