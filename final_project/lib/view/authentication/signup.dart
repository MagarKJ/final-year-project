// ignore_for_file: prefer_const_constructors

import 'package:final_project/view/authentication/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/bloc/signup/signup_bloc.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../bottom_navigtion_bar.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phonenoController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController bpController = TextEditingController();
  final TextEditingController sugarController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController(); // Separate controller for confirm password

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  bool _showConfirmPassword = false;
  int selectedAge = 1;

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
    nameController.dispose();
    emailController.dispose();
    phonenoController.dispose();
    weightController.dispose();
    bpController.dispose();
    sugarController.dispose();
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: Get.height * 0.15,
                    child: Image.asset("assets/logo/splashscreen.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Get Started!",
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        color: black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Create an account to log your daily activities.",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: myDarkGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: nameController,
                          prefixIcon: Icons.person,
                          hintText: "Full Name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.01),
                        CustomTextField(
                          controller: emailController,
                          prefixIcon: Icons.mail,
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.01),
                        CustomTextField(
                          controller: phonenoController,
                          prefixIcon: Icons.call,
                          hintText: "Phone No",
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.01),
                        CustomTextField(
                          controller: bpController,
                          prefixIcon: Icons.bloodtype,
                          hintText: "Blood Pressure",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your blood pressure';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.01),
                        CustomTextField(
                          controller: sugarController,
                          prefixIcon: Icons.bloodtype,
                          hintText: "Sugar Level",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your sugar level';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.01),
                        CustomTextField(
                          controller: weightController,
                          prefixIcon: Icons.monitor_weight,
                          hintText: "Weight",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your weight';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.01),
                        CustomTextField(
                          controller: passwordController,
                          prefixIcon: Icons.lock,
                          hintText: "Password",
                          obscureText: !_showPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.01),
                        CustomTextField(
                          controller: confirmPasswordController,
                          prefixIcon: Icons.lock,
                          hintText: "Confirm Password",
                          obscureText: !_showConfirmPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Container(
                          width: Get.width * 0.9,
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: primaryColor,
                                  thickness: 1,
                                  endIndent: 5,
                                ),
                              ),
                              Text(
                                'More Details about yourself',
                                style: GoogleFonts.inter(
                                  color: myDarkGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: primaryColor,
                                  thickness: 1,
                                  indent: 5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Text(

                                  Text(
                                    "Age: ",
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: myDarkGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  DropdownButton<int>(
                                    value: selectedAge,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        selectedAge = newValue!;
                                      });
                                    },
                                    items:
                                        List.generate(100, (index) => index + 1)
                                            .map<DropdownMenuItem<int>>(
                                                (int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(value.toString()),
                                      );
                                    }).toList(),
                                  ),

                                  SizedBox(width: 35),
                                  Text(
                                    "Gender: ",
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: myDarkGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: DropdownButton<String>(
                                      borderRadius: BorderRadius.circular(15),
                                      hint: Text(
                                        "Select Gender",
                                        style: TextStyle(
                                            fontFamily: 'inter', color: black),
                                      ),
                                      value: selectedGender,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedGender = newValue;
                                        });
                                      },
                                      autofocus: true,
                                      items: genders.map((String value) {
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
                                    "Ethnicity: ",
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: myDarkGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: DropdownButton<String>(
                                      borderRadius: BorderRadius.circular(15),
                                      hint: Text(
                                        "Select Ethnicity",
                                        style: TextStyle(
                                            fontFamily: 'inter', color: black),
                                      ),
                                      value: selectedEthnicity,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedEthnicity = newValue;
                                        });
                                      },
                                      items: ethnicities.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Row(
                                children: [
                                  Text(
                                    "Body Type: ",
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: myDarkGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: DropdownButton<String>(
                                      borderRadius: BorderRadius.circular(15),
                                      hint: Text(
                                        "Select Body Type",
                                        style: TextStyle(
                                            fontFamily: 'inter', color: black),
                                      ),
                                      value: selectedBodyType,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedBodyType = newValue;
                                        });
                                      },
                                      items: bodyTypes.map((String value) {
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
                                    "Body Goal: ",
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: myDarkGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: DropdownButton<String>(
                                      borderRadius: BorderRadius.circular(15),
                                      hint: Text(
                                        "Select Body Goal",
                                        style: TextStyle(
                                            fontFamily: 'inter', color: black),
                                      ),
                                      value: selectedBodyGoal,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedBodyGoal = newValue;
                                        });
                                      },
                                      items: bodyGoals.map((String value) {
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
                        SizedBox(height: Get.height * 0.02),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                RichText(
                  text: TextSpan(
                    text: "By clicking the ",
                    style: GoogleFonts.jost(
                        color: myDarkGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                        text: "Register",
                        style: GoogleFonts.jost(
                            color: myRed,
                            fontSize: 13,
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
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
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
                      return Center(
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
                                  sex: selectedGender ??
                                      '', // Use selectedGender
                                  weight: weightController.text.trim(),
                                  bloodPressue: bpController.text.trim(),
                                  bloodSugar: sugarController.text.trim(),
                                  bodygoal: selectedBodyGoal ??
                                      '', // Use selectedBodyGoal
                                  bodytype: selectedBodyType ??
                                      '', // Use selectedBodyType
                                  ethnicity: selectedEthnicity ??
                                      '', // Use selectedEthnicity
                                  age:
                                      selectedAge.toString(), // Use _currentAge
                                ),
                              );
                        }
                      },
                      width: Get.width * 0.8,
                      height: Get.height * 0.06,
                      fontSize: 18,
                      backGroundColor: primaryColor,
                    );
                  },
                ),
                SizedBox(height: Get.height * 0.02),
                RichText(
                  text: TextSpan(
                    text: "I Already Have an Account. ",
                    style: GoogleFonts.inter(
                        fontSize: 13.43,
                        color: myDarkGrey,
                        fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          fontFamily: 'inter',
                          decoration: TextDecoration.underline,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offAll(() => LoginScreen());
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
