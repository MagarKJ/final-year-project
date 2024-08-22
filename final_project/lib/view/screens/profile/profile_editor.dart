import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:final_project/controller/apis/user_data_repository.dart';
import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/bloc/profile/profile_bloc.dart';
import '../../../utils/global_variables.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/dropdownfield.dart';

class EditYourProfile extends StatefulWidget {
  const EditYourProfile({super.key});

  @override
  State<EditYourProfile> createState() => _EditYourProfileState();
}

class _EditYourProfileState extends State<EditYourProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ethnicityController = TextEditingController();
  TextEditingController bodyTypeController = TextEditingController();
  TextEditingController bodyGoalController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController sugarController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  GetUserData user = GetUserData();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phonenoController.dispose();
    ageController.dispose();
    weightController.dispose();
    ethnicityController.dispose();
    bodyTypeController.dispose();
    bodyGoalController.dispose();
    bpController.dispose();
    sugarController.dispose();
    sexController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void getUserData() async {
    var res = await user.getUserData(token: token);
    setState(() {
      nameController.text = res['user']['name'] ?? '';
      emailController.text = res['user']['email'] ?? '';
      phonenoController.text = res['user']['phone'] ?? '';
      ageController.text = res['user']['age'].toString() ?? '';
      sexController.text = res['user']['sex'] ?? '';
      weightController.text = res['user']['weight'] ?? '';
      ethnicityController.text = res['user']['ethnicity'] ?? "";
      bodyTypeController.text = res['user']['bodyType'] ?? '';
      bodyGoalController.text = res['user']['bodyGoal'] ?? '';
      bpController.text = res['user']['bloodPressure'] ?? '';
      sugarController.text = res['user']['bloodSugar'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: myBrownColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Edit Your Profile',
          style: GoogleFonts.jost(
            color: myBrownColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileEditorLoadedState) {
            // emailController.text = state.userData['email'];
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Form(
                    key: formKey,
                    child: SizedBox(
                      width: Get.width * 0.831,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: nameController,
                              prefixIcon: Icons.person,
                              hintText: "Full Name",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your name';
                                } else if (!RegExp(r'^[a-zA-Z ]+$')
                                    .hasMatch(value)) {
                                  return 'Name must contain at least one alphabets';
                                }
                                return null;
                              }),
                          SizedBox(height: Get.height * 0.02),
                          CustomTextField(
                            controller: emailController,
                            prefixIcon: Icons.call,
                            hintText: "Email",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              } else if (EmailValidator.validate(value) ==
                                  false) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          CustomTextField(
                            controller: phonenoController,
                            prefixIcon: Icons.call,
                            hintText: "Phone No",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              } else if (value.length < 10) {
                                return 'Phone number must be 10 digits';
                              } else if (value.length > 10) {
                                return 'Phone number must be 10 digits';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          CustomTextField(
                            controller: ageController,
                            prefixIcon: Icons.person,
                            hintText: "Age",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your age';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          CustomTextField(
                            controller: weightController,
                            prefixIcon: Icons.monitor_weight,
                            hintText: "Weight",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your weight';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          CustomDropDownField(
                            controller: sexController,
                            hintText: 'Sex',
                            prefixIcon: Icons.safety_check,
                            selectSomething: 'Select Your Sex',
                            option1: 'Male',
                            option2: 'Female',
                            option3: 'Others',
                            option4: null,
                            option5: null,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          CustomDropDownField(
                            controller: ethnicityController,
                            hintText: 'Ethnicity',
                            prefixIcon: Icons.safety_check,
                            selectSomething: 'Select Your Ethnicity',
                            option1: 'Asian',
                            option2: 'African',
                            option3: 'Caucasian',
                            option4: 'Hispanic',
                            option5: 'Others',
                          ),
                          SizedBox(height: Get.height * 0.02),
                          CustomDropDownField(
                            controller: bodyTypeController,
                            hintText: 'Body Type',
                            prefixIcon: Icons.safety_check,
                            selectSomething: 'Select Your BodyType',
                            option1: 'Morbidly Obese',
                            option2: 'Obese',
                            option3: 'Over Weight',
                            option4: 'Average',
                            option5: 'Lean',
                          ),
                          SizedBox(height: Get.height * 0.02),
                          CustomDropDownField(
                            controller: bodyGoalController,
                            hintText: 'Body Goal',
                            prefixIcon: Icons.safety_check,
                            selectSomething: 'Select Your BodyGoal',
                            option1: 'Lean',
                            option2: 'Muscular',
                            option3: 'Slim',
                            option4: 'Fatloss',
                            option5: null,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          CustomTextField(
                            controller: bpController,
                            prefixIcon: Icons.bloodtype,
                            hintText: "Blood Pressure",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your blood pressure';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          CustomTextField(
                            controller: sugarController,
                            prefixIcon: Icons.bloodtype,
                            hintText: "Sugar Level",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your sugar level';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: Get.height * 0.02),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  CustomButton(
                    buttonText: 'Edit',
                    onPressed: () {
                      log('message');
                      BlocProvider.of<ProfileBloc>(context).add(
                        UpdateUserData(
                          name: nameController.text.trim(),
                          age: ageController.text.trim(),
                          phoneno: phonenoController.text.trim(),
                          email: emailController.text.trim(),
                          sex: sexController.text.trim(),
                          weight: weightController.text.trim(),
                          ethnicity: ethnicityController.text.trim(),
                          bodytype: bodyTypeController.text.trim(),
                          bodygoal: bodyGoalController.text.trim(),
                          bloodPressue: bpController.text.trim(),
                          bloodSugar: sugarController.text.trim(),
                        ),
                      );
                      log('message2');
                    },
                    width: Get.width * 0.3,
                    height: Get.height * 0.06,
                    fontSize: 14,
                    backGroundColor: myBrownColor,
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
