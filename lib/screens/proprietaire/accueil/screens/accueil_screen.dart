import 'package:ahio/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../../themes/themes.dart';
import '../../../../widgets/widgets.dart';
import '../../../residence/residence.dart';

class AccueilProprioScreen extends StatefulWidget {
  const AccueilProprioScreen({super.key});

  @override
  State<AccueilProprioScreen> createState() => _AccueilProprioScreenState();
}

class _AccueilProprioScreenState extends State<AccueilProprioScreen> {
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
          SizedBox(
            height: 30.h,
            child: Stack(
              children: [
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                  child: Container(
                    margin: EdgeInsets.only(left: 3.w),
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ajouter votre \nrésidence",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                              color: colorBlack,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
