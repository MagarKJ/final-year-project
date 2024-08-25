// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'dart:developer' as developer;

import 'package:final_project/controller/apis/register_response.dart';
import 'package:final_project/controller/bloc/login/login_bloc.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/authentication/forgotpas.dart';
import 'package:final_project/view/authentication/login-api.dart';
import 'package:final_project/view/authentication/signup.dart';

import 'package:final_project/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isRememberMe = false;
  final formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  late AnimationController _controller;
  late Animation<double> _animation;
  final String _text = 'Welcome Back!';
  final String _text1 = 'Always Keep Yourself Healthy.';

  final int _durationPerLetter = 100;
  String email = '';
  String password = '';

  @override
  void initState() {
    loadPreferences();
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: _text1.length * _durationPerLetter),
      vsync: this,
    )..forward();
    _animation = Tween<double>(begin: 0, end: _text1.length.toDouble())
        .animate(_controller);
  }

  googleLogin() async {
    RegisterRepository registerRepository = RegisterRepository();
    try {
      developer.log('Google Sign In Clicked');
      UserCredential? user = await signInWithGoogle();
      developer.log('Sign In with Google completed, UserCredential: $user');

      try {
        if (user != null) {
          developer.log("User is not null, proceeding with registration");

          await registerRepository.loginWithGoogle();
        } else {
          developer.log("User is null after Google Sign In");
        }
      } catch (e) {
        developer.log("Exception during registration process: $e");
      }
    } catch (e) {
      developer.log("Exception during Google Sign In: $e");
    }
  }

  void loadPreferences() async {
    // log('login load preferences called');
    String? email = await getEmail1();
    // log('login kon email is $email');
    bool? _isRememberMe = await getRememberMe();
    // log('is remember me $_isRememberMe');
    String? password = await getPassword();

    setState(() {
      email = email;
      password = password;
      _isRememberMe = _isRememberMe!;
    });
    if (_isRememberMe == true) {
      emailController.text = email.toString();
      passwordController.text = password.toString();
      // log('email controller ${emailController.text}');
      _isRememberMe = true;
    }
  }

  Future<bool?> getRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isRememberMe = prefs.getBool('rememberMe') ?? false;
    return _isRememberMe;
  }

  Future<String?> getEmail1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') ?? '';
    // log('email is ${prefs.getString('email_address')}');
    return email;
  }

  Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    password = prefs.getString('password') ?? '';
    // log('password is ${prefs.getString('password')}');
    return password;
  }

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
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: Get.height,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset("assets/logo/splashscreen.png"),
                  ),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      int currentLength = _animation.value.round();
                      String currentText =
                          _text.substring(0, min(_text.length, currentLength));

                      return Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            currentText,
                            style: GoogleFonts.inter(
                                fontSize: 26,
                                color: black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      int currentLength = _animation.value.round();
                      String currentText1 = _text1.substring(
                          0, min(currentLength, _text1.length));

                      return Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            currentText1,
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                color: myDarkGrey,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          CustomTextField(
                            prefixIcon: Icons.email,
                            hintText: 'Email',
                            obscureText: false,
                            controller: emailController,
                          ),
                          SizedBox(height: Get.height * 0.015),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _isRememberMe,
                            onChanged: (value) {
                              setState(() {
                                _isRememberMe = !_isRememberMe;
                              });
                            },
                          ),
                          Text("Remember Me",
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: black,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.inter(
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: black,
                              // decoration: TextDecoration.underline,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return CustomButton(
                        buttonText: 'Log In',
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          //shared preferences ko value true gardinxa kina ki eak pali login vaye paxi login page ma janu pardaina

                          prefs.setString('email', emailController.text.trim());
                          prefs.setString(
                              'password', passwordController.text.trim());
                          prefs.setBool('rememberMe', _isRememberMe);
                          if (formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                                  LoginRequestedEvent(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                          }
                        },
                        width: Get.width * 0.8,
                        height: Get.height * 0.06,
                        fontSize: 20,
                        backGroundColor: primaryColor,
                      );
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Column(
                    children: [
                      // Container(
                      //   width: Get.width * 0.9,
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: Divider(
                      //           color: primaryColor,
                      //           thickness: 1,
                      //           endIndent: 5,
                      //         ),
                      //       ),
                      //       Text(
                      //         'OR',
                      //         style: GoogleFonts.inter(
                      //           color: black,
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.w400,
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: Divider(
                      //           color: primaryColor,
                      //           thickness: 1,
                      //           indent: 5,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: Get.height * 0.02,
                      // ),
                      // BlocBuilder<LoginBloc, LoginState>(
                      //   builder: (context, state) {
                      //     return GestureDetector(
                      //       onTap: () {
                      //         googleLogin();
                      //       },
                      //       child: Container(
                      //         width: Get.width * 0.8,
                      //         height: Get.height * 0.06,
                      //         decoration: BoxDecoration(
                      //           border: Border.all(
                      //             color: Colors.black.withOpacity(0.06),
                      //             width: 2,
                      //           ),
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Image.asset(
                      //               googleLogo,
                      //               width: 40,
                      //             ),
                      //             const SizedBox(
                      //               width: 15,
                      //             ),
                      //             Text(
                      //               'Continue with Google',
                      //               style: GoogleFonts.inter(
                      //                 color: black,
                      //                 fontSize: 16,
                      //                 fontWeight: FontWeight.w600,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                      // SizedBox(
                      //   height: Get.height * 0.02,
                      // ),
                      RichText(
                        text: TextSpan(
                          text: "Don't Have an Account? ",
                          style: GoogleFonts.inter(
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
        ),
      ),
    );
  }
}
