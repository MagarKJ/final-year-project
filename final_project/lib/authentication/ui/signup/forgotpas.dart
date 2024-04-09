import 'package:final_project/custom_button.dart';
import 'package:final_project/custom_text_field.dart';
import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.25,
          ),
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.32),
            child: SizedBox(
              height: Get.height * 0.05,
              width: Get.width * 0.5,
              child: Text(
                "Forgot password?",
                style: GoogleFonts.jost(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: myBrownColor),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.0645,
                  width: Get.width * 0.831,
                  child: CustomTextField(
                    prefixIcon: Icons.mail,
                    hintText: 'Enter your email address',
                    obscureText: false,
                    controller: emailController,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                RichText(
                  text: TextSpan(
                    text: "*",
                    style: const TextStyle(color: Color(0xFFFF4B26)),
                    children: [
                      TextSpan(
                        text:
                            " We will send you a message to set or reset your new password",
                        style: GoogleFonts.montserrat(
                            color: myDarkGrey,
                            fontSize: 11.43,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          CustomButton(
            buttonText: 'Submit',
            onPressed: () {},
            width: Get.width * 0.5,
            height: Get.height * 0.07,
            fontSize: 15,
            backGroundColor: myBrownColor,
          ),
        ],
      ),
    );
  }
}
