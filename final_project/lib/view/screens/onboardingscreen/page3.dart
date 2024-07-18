// ignore_for_file: prefer_const_constructors

import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "'Fitness is the ultimate fashion.'",
              style: GoogleFonts.sail(
                  fontSize: 24, color: myDarkGrey, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 40,
            ),
            Image.asset("assets/logo/onboard.png"),
          ],
        ),
      ),
    );
  }
}
