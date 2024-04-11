import 'package:final_project/view/screens/onboardingscreen/onbardingscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(() => const OnBoardScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            fadeOutDuration: const Duration(milliseconds: 200),
            image: const AssetImage('assets/logo/logo.jpeg'),
          ),
        ),
      ),
    );
  }
}
