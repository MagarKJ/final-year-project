// ignore_for_file: prefer_const_constructors

import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "'Fitness isn’t a goal it is a lifestyle.'",
              style: GoogleFonts.sail(
                  fontSize: 24, color: myDarkGrey, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 40,
            ),
            Image.asset("assets/logo/Wellbeing.png"),
          ],
        ),
      ),
    );
  }
}
