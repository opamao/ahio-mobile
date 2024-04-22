import 'package:ahio/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class ResidencesScreen extends StatefulWidget {
  const ResidencesScreen({super.key});

  @override
  State<ResidencesScreen> createState() => _ResidencesScreenState();
}

class _ResidencesScreenState extends State<ResidencesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 250, 230),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const Gap(40),
          Container(
            padding: const EdgeInsets.only(left: 25),
            child: const Text(
              "Mes résidences",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
          const Gap(16),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.66,
            padding: const EdgeInsets.all(5.0),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            shrinkWrap: true,
            children: [
              InkWell(
                onTap: () {},
                child: Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.w),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.w),
                            ),
                            image: const DecorationImage(
                              image: AssetImage("images/sal1.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Appartement",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Abidjan",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                      Text(
                                        "08 Jan - 18 Jan",
                                        style: TextStyle(
                                          color: colorPrimary,
                                          fontSize: 8.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(1.w),
                                    margin: EdgeInsets.all(2.w),
                                    decoration: BoxDecoration(
                                      color: colorPrimary,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.w),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "25.000 F",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "La nuit",
                                          style: TextStyle(
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
