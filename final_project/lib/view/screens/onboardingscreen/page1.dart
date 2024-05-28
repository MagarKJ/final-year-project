import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset(goodMorning),
    );
  }
}
