import 'dart:developer';
import 'package:email_validator/email_validator.dart';
import 'package:final_project/controller/apis/user_data_repository.dart';
import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/bloc/profile/profile_bloc.dart';
import '../../../utils/global_variables.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class EditYourProfile extends StatefulWidget {
  const EditYourProfile({super.key});

  @override
  State<EditYourProfile> createState() => _EditYourProfileState();
}

class _EditYourProfileState extends State<EditYourProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();

  TextEditingController weightController = TextEditingController();

  TextEditingController bpController = TextEditingController();
  TextEditingController sugarController = TextEditingController();

  GetUserData user = GetUserData();
  final formKey = GlobalKey<FormState>();
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
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phonenoController.dispose();

    weightController.dispose();

    bpController.dispose();
    sugarController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  void getUserData() async {
    var res = await user.getUserData(token: token);
    setState(() {
      nameController.text = res['user']['name'] ?? '';
      emailController.text = res['user']['email'] ?? '';
      phonenoController.text = res['user']['phone'] ?? '';
      selectedAge = res['user']['age'] ?? '';
      selectedGender = res['user']['sex'] ?? '';
      weightController.text = res['user']['weight'] ?? '';
      selectedEthnicity = res['user']['ethnicity'] ?? "";
      selectedBodyType = res['user']['bodyType'] ?? '';
      selectedBodyGoal = res['user']['bodyGoal'] ?? '';
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
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Edit Your Profile',
          style: GoogleFonts.jost(
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
                          SizedBox(height: Get.height * 0.01),
                          CustomTextField(
                            controller: emailController,
                            prefixIcon: Icons.mail,
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
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: Get.height * 0.01),
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
                          SizedBox(height: Get.height * 0.01),
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
                          SizedBox(height: Get.height * 0.01),
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
                          SizedBox(height: Get.height * 0.01),
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
                          SizedBox(height: Get.height * 0.02),
                          Column(
                            children: [
                              Row(
                                children: [
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
                                    dropdownColor: whiteColor,
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
                                  const SizedBox(width: 35),
                                  Text(
                                    "Gender: ",
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: myDarkGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    child: DropdownButton<String>(
                                      dropdownColor: whiteColor,
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
                                      dropdownColor: whiteColor,
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
                              const SizedBox(width: 10),
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
                                  DropdownButton<String>(
                                    dropdownColor: whiteColor,
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
                                      dropdownColor: whiteColor,
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
                          age: selectedAge.toString(),
                          phoneno: phonenoController.text.trim(),
                          email: emailController.text.trim(),
                          sex: selectedGender ?? '',
                          weight: weightController.text.trim(),
                          ethnicity: selectedEthnicity ?? '',
                          bodytype: selectedBodyType ?? '',
                          bodygoal: selectedBodyGoal ?? '',
                          bloodPressue: bpController.text.trim(),
                          bloodSugar: sugarController.text.trim(),
                        ),
                      );
                      log('message2');
                    },
                    width: Get.width * 0.8,
                    height: Get.height * 0.06,
                    fontSize: 18,
                    backGroundColor: primaryColor,
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
