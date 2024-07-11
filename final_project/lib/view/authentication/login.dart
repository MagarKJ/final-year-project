import 'package:final_project/controller/bloc/login/login_bloc.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/authentication/forgotpas.dart';
import 'package:final_project/view/authentication/signup.dart';
import 'package:final_project/view/bottom_navigtion_bar.dart';

import 'package:final_project/widgets/custom_button.dart';
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
  bool _isRememberMe = false;

  String email = '';
  String password = '';

  @override
  void initState() {
    loadPreferences();
    // TODO: implement initState
    super.initState();
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
    email = prefs.getString('email_address') ?? '';
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Column(
                children: [
                  Text(
                    "Login To Your Account",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      cursorColor: secondaryColor,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        if (value.length < 10) {
                          return 'Please enter valid Email';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          floatingLabelStyle: floatingLabelTextStyle(),
                          prefixIcon: Icon(
                            Icons.email,
                            color: myGrey,
                          ),
                          focusedBorder: customFocusBorder(),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: secondaryColor, width: 2)),
                          labelStyle: TextStyle(color: myGrey, fontSize: 13),
                          labelText: 'Enter Your Email',
                          hintText: 'Enter Your Email'),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  TextFormField(
                    cursorColor: secondaryColor,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.go,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                        floatingLabelStyle:
                            TextStyle(color: secondaryColor, fontSize: 13),
                        focusedBorder: customFocusBorder(),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: secondaryColor, width: 2)),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: myGrey,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: (_showPassword)
                              ? Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: myGrey,
                                )
                              : Icon(
                                  Icons.remove_red_eye,
                                  color: myGrey,
                                ),
                        ),
                        labelStyle: TextStyle(color: myGrey, fontSize: 13),
                        labelText: 'Enter Your Password',
                        hintText: 'Enter Your Password'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            activeColor: secondaryColor,
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
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: myGrey,
                              // decoration: TextDecoration.underline,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonText: 'Log In',
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      if (formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(
                              LoginRequestedEvent(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                      prefs.setBool('Login', true);
                      prefs.setString('email', emailController.text.trim());
                      prefs.setString(
                          'password', passwordController.text.trim());
                    },
                    width: Get.width * 0.6,
                    height: Get.height * 0.06,
                    fontSize: 15,
                    backGroundColor: primaryColor,
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Container(
                    width: Get.width * 0.8,
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: secondaryColor,
                            thickness: 2,
                            endIndent: 5,
                          ),
                        ),
                        Text(
                          'OR',
                          style: GoogleFonts.inter(
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: secondaryColor,
                            thickness: 2,
                            indent: 5,
                          ),
                        ),
                      ],
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
                        Get.offAll(() => MyBottomNavigationBar());
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
                              Image.asset(
                                googleLogo,
                              ),
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
            ),
          ),
        ),
      ),
    );
  }
}
