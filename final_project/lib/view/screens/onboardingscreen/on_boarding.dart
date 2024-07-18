// ignore_for_file: prefer_const_constructors

import 'package:final_project/view/authentication/login.dart';
import 'package:final_project/view/screens/onboardingscreen/onbardingscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void setOnBoardingCount() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setInt('boardingCount', 2);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200]!,
      body: Stack(
        children: [
          Center(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                height: Get.height * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo/getfit.png'),
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          'Where Results Happen',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Welcome to',
                          style: GoogleFonts.lobster(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Get Fit.',
                          style: GoogleFonts.lobster(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Empowering Your Fitness Dreams With Our Health and Fitness Monitoring App.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: myDarkGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Get.height * 0.075,
            left: Get.width * 0.18,
            right: Get.width * 0.18,
            child: Container(
              width: Get.width * 0.7,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {
                  Get.off(() => LoginScreen());
                },
                child: const Text(
                  'GET STARTED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
