import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../../themes/themes.dart';

class GainsScreen extends StatefulWidget {
  const GainsScreen({super.key});

  @override
  State<GainsScreen> createState() => _GainsScreenState();
}

class _GainsScreenState extends State<GainsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 250, 230),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              child: const Text(
                "Mes gains",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 4.w,
                          color: colorPrimary,
                          height: 4.w,
                        ),
                      ),
                      Gap(1.h),
                      Text(
                        "Résidence 1 (Nom - description résidence)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                  Gap(1.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(3.w),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.attach_money_outlined,
                                    size: 15.sp,
                                  ),
                                  Text(
                                    "Montant par nuit :",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Gap(2.w),
                                  Text(
                                    "25 000 Fcfa",
                                    style: TextStyle(
                                      color: colorPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(2.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.nightlight_round_outlined,
                                    size: 15.sp,
                                  ),
                                  Text(
                                    "Nombre de nuit :",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Gap(2.w),
                                  Text(
                                    "19 nuits",
                                    style: TextStyle(
                                      color: colorPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        ClipOval(
                                          child: Container(
                                            width: 3.w,
                                            color: colorPrimary,
                                            height: 3.w,
                                          ),
                                        ),
                                        Gap(1.h),
                                        Text(
                                          "01 Jan - 03 Jan",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        ClipOval(
                                          child: Container(
                                            width: 3.w,
                                            color: colorPrimary,
                                            height: 3.w,
                                          ),
                                        ),
                                        Gap(1.h),
                                        Text(
                                          "01 Jan - 03 Jan",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.5.w),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "25 000 X 19 = ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                              Text(
                                "485 000 Fcfa",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
