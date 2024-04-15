import 'package:final_project/controller/bloc/login/login_bloc.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/authentication/forgotpas.dart';
import 'package:final_project/view/authentication/signup.dart';
import 'package:final_project/view/bottom_navigtion_bar.dart';

import 'package:final_project/widgets/custom_button.dart';
import 'package:final_project/widgets/custom_text_field.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Listner use gareko kina ki listen ni garna xa rw build ni garna xa
      //blocConsumer is BlocListener + BlocBuilder
      //BlocListener used for functionality that needs to occur once per state change such as navigation, showing a snackbarr, shpowing a dialog, etc.a dialog etc.
      //BlocBuilder used for functionality that needs to occur for every state change such as showing a loading indicator, updating a widget with new data, etc.

      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is LoginSuccessstate) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            //shared preferences ko value true gardinxa kina ki eak pali login vaye paxi login page ma janu pardaina
            prefs.setBool('Login', true);
            prefs.setString('email', emailController.text.trim());
            prefs.setString('password', passwordController.text.trim());

            //offAll use gareko kina ki login vaye paxi login page ma janu pardaina
            //Get.to use garyo vane pheri yei screen ma farkina milxa ani offAll use gareko vane login
            //vaye paxi login page ma janu paudaina kina ki sab baki lai remove gardinxa
            Get.offAll(() => const MyBottomNavigationBar());
            //auth bloc mai xaaa
          }
          if (state is LoginFailurestate) {
            Get.snackbar('Login Failed', state.error);
          }
        },
        builder: (context, state) {
          //login loading state xa vane loading indicator dekhauxa
          if (state is LoginLoadingstate) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.17,
                ),
                SizedBox(
                  height: Get.height * 0.06,
                  width: Get.width * 0.831,
                  child: Text(
                    "Log in into your account",
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
                    height: Get.height * 0.18,
                    width: Get.width * 0.831,
                    child: Column(
                      children: [
                        CustomTextField(
                          prefixIcon: Icons.person,
                          hintText: 'Email',
                          obscureText: false,
                          controller: emailController,
                        ),
                        SizedBox(height: Get.height * 0.04),
                        CustomTextField(
                          prefixIcon: Icons.lock,
                          hintText: 'Password',
                          obscureText: true,
                          showPassword: _showPassword,
                          onTogglePassword: (bool show) {
                            setState(() {
                              _showPassword = show;
                            });
                          },
                          controller: passwordController,
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => const ForgotPassword());
                  },
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.jost(
                      color: myGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.07,
                ),
                CustomButton(
                  buttonText: 'Log In',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(
                            LoginRequestedEvent(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                    }
                  },
                  width: Get.width * 0.6,
                  height: Get.height * 0.07,
                  fontSize: 15,
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
                          child: Image.asset(googleLogo),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: Get.height * 0.02,
                        ),
                        GestureDetector(
                          child: Image.asset(appleLogo),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: Get.height * 0.02,
                        ),
                        GestureDetector(
                          child: Image.asset(facebookLogo),
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "I Don't Have an Account ",
                        style: GoogleFonts.jost(
                            fontSize: 13.43,
                            color: myDarkGrey,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: myBrownColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => const CreateAccount());
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
}
