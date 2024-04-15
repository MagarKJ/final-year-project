import 'package:final_project/controller/bloc/fogrotpassword/forpas_bloc.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/authentication/login.dart';
import 'package:final_project/widgets/custom_button.dart';
import 'package:final_project/widgets/custom_text_field.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    return Scaffold(
      body: BlocConsumer<ForpasBloc, ForpasState>(
        listener: (context, state) {
          if (state is ForpasLoadingstate) {}
          if (state is ForpasSuccessstate) {
            Get.snackbar(
              "Success",
              "Password reset link has been sent to your email",
            );
            print('Reset button tichiyo');
            Get.offAll(() => const LoginScreen());
          }
          if (state is ForpasFailurestate) {
            Get.snackbar(
              "Error",
              state.error,
            );
          }
        },
        builder: (context, state) {
          if (state is ForpasLoadingstate) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Column(
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
                onPressed: () {
                  BlocProvider.of<ForpasBloc>(context).add(
                    ForpasRequestedEvent(
                      email: emailController.text,
                    ),
                  );
                },
                width: Get.width * 0.5,
                height: Get.height * 0.07,
                fontSize: 15,
                backGroundColor: myBrownColor,
              ),
            ],
          );
        },
      ),
    );
  }
}
