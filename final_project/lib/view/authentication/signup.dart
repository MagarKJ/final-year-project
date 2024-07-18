// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:final_project/controller/bloc/signup/signup_bloc.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/authentication/login.dart';
import 'package:final_project/view/bottom_navigtion_bar.dart';
import 'package:final_project/widgets/custom_button.dart';
import 'package:final_project/widgets/custom_text_field.dart';
import 'package:final_project/widgets/dropdownfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phonenoController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final bpController = TextEditingController();
  final sugarController = TextEditingController();
  final sexController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  int _currentAge = 0;

  String? selectedGender;
  String? selectedEthnicity;
  String? selectedBodyType;
  String? selectedBodyGoal;

  final List<String> genders = ["Male", "Female", "Other"];
  final List<String> ethnicities = [
    "Asian",
    "African",
    "Caucasian",
    "Hispanic",
    "Others"
  ];
  final List<String> bodyTypes = [
    "Morbidly Obese",
    "Obese",
    "Over Weight",
    "Average",
    "Lean"
  ];
  final List<String> bodyGoals = ["Lean", "Muscular", "Slim", "Fatloss"];
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
      backgroundColor: whiteColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: Get.height * 0.15,
                      child: Image.asset("assets/logo/splashscreen.png"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Create an account",
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          color: black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              controller: nameController,
                              prefixIcon: Icons.person,
                              hintText: "Full Name",
                            ),
                            SizedBox(height: Get.height * 0.01),
                            CustomTextField(
                              prefixIcon: Icons.mail,
                              hintText: "Email",
                              obscureText: false,
                              controller: emailController,
                            ),
                            SizedBox(height: Get.height * 0.01),
                            CustomTextField(
                              controller: phonenoController,
                              prefixIcon: Icons.call,
                              hintText: "Phone No",
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: Get.height * 0.02),
                            CustomTextField(
                              controller: bpController,
                              prefixIcon: Icons.bloodtype,
                              hintText: "Blood Pressure",
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: Get.height * 0.02),
                            CustomTextField(
                              controller: sugarController,
                              prefixIcon: Icons.bloodtype,
                              hintText: "Sugar Level",
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: Get.height * 0.02),
                            CustomTextField(
                              controller: weightController,
                              prefixIcon: Icons.monitor_weight,
                              hintText: "Weight",
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: Get.height * 0.02),
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
                            SizedBox(height: Get.height * 0.02),
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
                            SizedBox(height: Get.height * 0.01),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Age: ",
                                          style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: myDarkGrey,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: DropdownButton<int>(
                                            value: _currentAge,
                                            onChanged: (int? newValue) {
                                              setState(() {
                                                _currentAge = newValue!;
                                              });
                                            },
                                            items: List.generate(
                                                    100, (index) => index + 1)
                                                .map<DropdownMenuItem<int>>(
                                                    (int value) {
                                              return DropdownMenuItem<int>(
                                                value: value,
                                                child: Text(value.toString()),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          "Gender: ",
                                          style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: myDarkGrey,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: DropdownButton<String>(
                                            hint: Text("Select Gender"),
                                            value: selectedGender,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedGender = newValue;
                                              });
                                            },
                                            items: genders
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.02),
                                    Row(
                                      children: [
                                        Text(
                                          "Ethnicity: ",
                                          style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: myDarkGrey,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        DropdownButton<String>(
                                          hint: Text("Select Ethnicity"),
                                          value: selectedEthnicity,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedEthnicity = newValue;
                                            });
                                          },
                                          items: ethnicities
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Body Type:",
                                          style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: myDarkGrey,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: DropdownButton<String>(
                                            hint: Text("Select Body Type"),
                                            value: selectedBodyType,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedBodyType = newValue;
                                              });
                                            },
                                            items: bodyTypes
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Body Goal:",
                                          style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: myDarkGrey,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: DropdownButton<String>(
                                            hint: Text("Select Body Goal"),
                                            value: selectedBodyGoal,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedBodyGoal = newValue;
                                              });
                                            },
                                            items: bodyGoals
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  RichText(
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
                          text: " button, you agree to the public offer.",
                          style: GoogleFonts.jost(
                              color: myDarkGrey,
                              fontSize: 11.43,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  BlocConsumer<SignupBloc, SignupState>(
                    listener: (context, state) async {
                      if (state is SignupSuccessstate) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('Login', true);
                        Get.offAll(() => MyBottomNavigationBar());
                      }
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
                      return CustomButton(
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
                                    age: ageController.text.trim(),
                                  ),
                                );
                          }
                        },
                        width: Get.width * 0.7,
                        height: Get.height * 0.06,
                        fontSize: 14,
                        backGroundColor: primaryColor,
                      );
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
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
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Get.back();
                              Get.offAll((_) => LoginScreen());
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
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
