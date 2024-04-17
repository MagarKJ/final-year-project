import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/bloc/profile/profile_bloc.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/dropdownfield.dart';

class EditYourProfile extends StatefulWidget {
  const EditYourProfile({super.key});

  @override
  State<EditYourProfile> createState() => _EditYourProfileState();
}

class _EditYourProfileState extends State<EditYourProfile> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phonenoController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final bpController = TextEditingController();
  final sugarController = TextEditingController();
  final sexController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: Get.height * 0.12,
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                    width: Get.width * 0.831,
                    child: Text(
                      "Edit Your Details",
                      style: GoogleFonts.jost(
                          fontSize: 21,
                          color: myBrownColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
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
                          ),
                          SizedBox(height: Get.height * 0.02),
                          CustomTextField(
                            controller: phonenoController,
                            prefixIcon: Icons.call,
                            hintText: "Phone No",
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          CustomTextField(
                            controller: ageController,
                            prefixIcon: Icons.person,
                            hintText: "Age",
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
                          CustomDropDownField(
                            controller: sexController,
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
                            controller: sexController,
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
                            controller: sexController,
                            hintText: 'Body Goal',
                            prefixIcon: Icons.safety_check,
                            selectSomething: 'Select Your BodyGoal',
                            option1: 'Lean',
                            option2: 'Muscular',
                            option3: 'Slim',
                            option4: 'Fatloss',
                            option5: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  CustomButton(
                    buttonText: 'Edit',
                    onPressed: () {},
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
