import 'package:final_project/authentication/ui/signup/bloc/signup_bloc.dart';
import 'package:final_project/custom_button.dart';
import 'package:final_project/custom_text_field.dart';
import 'package:final_project/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phonenoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupFailurestate) {
            Get.snackbar('Signup Failed', state.error);
          }
        },
        builder: (context, state) {
          if (state is SignupLoadingstate) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.12,
                ),
                SizedBox(
                  height: Get.height * 0.06,
                  width: Get.width * 0.831,
                  child: Text(
                    "Create an account",
                    style: GoogleFonts.jost(
                        fontSize: 21,
                        color: myBrownColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Form(
                  key: formKey,
                  child: SizedBox(
                    height: Get.height * 0.5,
                    width: Get.width * 0.831,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: nameController,
                          prefixIcon: Icons.person,
                          hintText: "Full Name",
                        ),
                        SizedBox(height: Get.height * 0.04),
                        CustomTextField(
                          prefixIcon: Icons.mail,
                          hintText: "Email",
                          obscureText: false,
                          controller: emailController,
                        ),
                        SizedBox(height: Get.height * 0.04),
                        CustomTextField(
                          controller: phonenoController,
                          prefixIcon: Icons.call,
                          hintText: "Phone No",
                        ),
                        SizedBox(height: Get.height * 0.04),
                        CustomTextField(
                          prefixIcon: Icons.lock,
                          hintText: "Password",
                          obscureText: true,
                          showPassword: _showPassword,
                          onTogglePassword: (bool show) {
                            setState(() {
                              _showPassword = show;
                            });
                          },
                          controller: passwordController,
                        ),
                        SizedBox(height: Get.height * 0.04),
                        CustomTextField(
                          prefixIcon: Icons.lock,
                          hintText: "Confirm Password",
                          obscureText: true,
                          showPassword: _showConfirmPassword,
                          onTogglePassword: (bool show) {
                            setState(() {
                              _showConfirmPassword = show;
                            });
                          },
                          controller: confirmPasswordController,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.13),
                  child: SizedBox(
                    height: Get.height * 0.05,
                    width: Get.width * 0.677,
                    child: RichText(
                      text: TextSpan(
                        text: "By clicking the ",
                        style: GoogleFonts.jost(
                            color: myDarkGrey,
                            fontSize: 11.43,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: "Register",
                            style: GoogleFonts.jost(
                                color: myRed,
                                fontSize: 11.43,
                                fontWeight: FontWeight.w400),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle button click here
                              },
                          ),
                          TextSpan(
                            text: " button, you agree to the public offer",
                            style: GoogleFonts.jost(
                                color: myDarkGrey,
                                fontSize: 11.43,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                CustomButton(
                  buttonText: 'Create An Account',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<SignupBloc>().add(
                            SignupRequestedEvent(
                              email: emailController.text.trim(),
                              name: nameController.text.trim(),
                              phoneno: phonenoController.text.trim(),
                              password: passwordController.text.trim(),
                              confirmPassword:
                                  confirmPasswordController.text.trim(),
                            ),
                          );
                    }
                  },
                  width: Get.width * 0.55,
                  height: Get.height * 0.06,
                  fontSize: 14,
                  backGroundColor: myBrownColor,
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Column(
                  children: [
                    Center(
                      child: Text(
                        "- OR Continue with -",
                        style: GoogleFonts.jost(
                            fontSize: 12,
                            color: myDarkGrey,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Image.asset('assets/logo/google.png'),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: Get.height * 0.02,
                        ),
                        GestureDetector(
                          child: Image.asset('assets/logo/apple.png'),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: Get.height * 0.02,
                        ),
                        GestureDetector(
                          child: Image.asset('assets/logo/facebook.png'),
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "I Already Have an Account ",
                        style: GoogleFonts.jost(
                            fontSize: 13.43,
                            color: myDarkGrey,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: myBrownColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.back();
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  TextStyle greyText() {
    return TextStyle(
      color: myGrey,
    );
  }
}
