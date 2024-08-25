import 'dart:developer';

import 'package:final_project/utils/global_variables.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/bottom_navigtion_bar.dart';
import 'package:final_project/view/screens/onboardingscreen/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String keyLogin = "Login";
  @override
  void initState() {
    super.initState();
    getInfo();
    whereToGo();
  }

  void getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '';
    email1 = prefs.getString('email') ?? '';
    userId = prefs.getInt('userId') ?? '';
    token = prefs.getString('token') ?? '';
    image = prefs.getString('photo_name') ?? '';
    bloodPressure = prefs.getString('bloodPressure') ?? '';
    bloodSugar = prefs.getString('bloodSugar') ?? '';
    isPremium = prefs.getInt('isPremium') ?? 0;

    age = prefs.getInt('age') ?? 0;
    phoneno = prefs.getString('phone') ?? '';
    sex = prefs.getString('sex') ?? '';
    weight = prefs.getString('weight') ?? '';
    ethnicity = prefs.getString('ethnicity') ?? '';
    bodytype = prefs.getString('bodyType') ?? '';
    bodygoal = prefs.getString('bodyGoal') ?? '';

    log(name);
    log(email1);
    log(userId.toString());
    log(token);
    log(image);
    log(bloodPressure);
    log(bloodSugar);
    log(isPremium.toString());

    log(age.toString());
    log(phoneno);
    log(sex);
    log(weight);
    log(ethnicity);
    log(bodytype);
    log(bodygoal);
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
            image: const AssetImage(splashScreen),
          ),
        ),
      ),
    );
  }

  Future<void> whereToGo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(keyLogin) ?? false;

    await Future.delayed(
        const Duration(seconds: 2)); // Optional delay for splash screen

//if value false xa vane onboard screen ma janxa else bottom navigation bar ma janxa.
//Navigation bar vaneko home page ko bottom navigation bar homepage vanda hunxa
    if (isLoggedIn) {
      Get.offAll(() => MyBottomNavigationBar());
    } else {
      Get.offAll(() => const OnboardingScreen());
    }
  }
}
