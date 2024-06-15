import 'package:final_project/controller/bloc/login/login_bloc.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/authentication/forgotpas.dart';
import 'package:final_project/view/authentication/signup.dart';
import 'package:final_project/view/bottom_navigtion_bar.dart';

import 'package:final_project/widgets/custom_button.dart';
import 'package:final_project/widgets/custom_text_field.dart';
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
      backgroundColor: whiteColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
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
                      fontSize: 21, color: black, fontWeight: FontWeight.w700),
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
              BlocConsumer<LoginBloc, LoginState>(
                //Listner use gareko kina ki listen ni garna xa rw build ni garna xa
                //blocConsumer is BlocListener + BlocBuilder
                //BlocListener used for functionality that needs to occur once per state change such as navigation, showing a snackbarr, shpowing a dialog, etc.a dialog etc.
                //BlocBuilder used for functionality that needs to occur for every state change such as showing a loading indicator, updating a widget with new data, etc.

                listener: (context, state) async {
                  if (state is LoginSuccessstate) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
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
                  if (state is LoginLoadingstate) {
                    return const CircularProgressIndicator();
                  }
                  return CustomButton(
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
                    backGroundColor: primaryColor,
                  );
                },
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
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) async {
                      if (state is GoogleLoginSuccessstate) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('Login', true);
                        prefs.setString('email', emailController.text.trim());
                        prefs.setString(
                            'password', passwordController.text.trim());
                        Get.offAll(() => const MyBottomNavigationBar());
                      }
                      if (state is GoogleLoginFailurestate) {
                        Get.snackbar('Login Failed', state.error);
                      }
                    },
                    builder: (context, state) {
                      if (state is GoogleLoginLoadingstate) {
                        return const CircularProgressIndicator();
                      }
                      return GestureDetector(
                        child: Container(
                          width: Get.width * 0.72,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: myGrey.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(googleLogo),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Text(
                                'Continue with Google',
                                style: GoogleFonts.jost(
                                    fontSize: 15,
                                    color: myDarkGrey,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          context
                              .read<LoginBloc>()
                              .add(GoogleLoginRequestedEvent());
                        },
                      );
                    },
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
                            color: primaryColor,
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
        ),
      ),
    );
  }
}
