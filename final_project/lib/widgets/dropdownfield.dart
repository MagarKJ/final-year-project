
import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDownField extends StatelessWidget {
  final String hintText;
  final String option1;
  final String option2;
  final String option3;
  final String? option4;
  final String? option5;
  final IconData prefixIcon;
  final String selectSomething;
  final TextEditingController controller;
  const CustomDropDownField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.selectSomething,
    required this.option1,
    required this.option2,
    required this.option3,
    this.option4,
    this.option5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.0645,
      child: TextFormField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: myBrownColor),
            borderRadius: BorderRadius.circular(3),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: myGrey),
            borderRadius: BorderRadius.circular(3),
          ),
          prefixIcon: Icon(prefixIcon, color: myGrey),
          hintStyle: GoogleFonts.montserrat(
            color: myGrey,
            fontSize: 11.43,
            fontWeight: FontWeight.w500,
          ),
          hintText: hintText,
          floatingLabelAlignment: FloatingLabelAlignment.center,
        ),
        readOnly: true,
        controller: controller,
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(selectSomething),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(option1),
                          onTap: () {
                            controller.text = option1;
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          title: Text(option2),
                          onTap: () {
                            controller.text = option2;
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          title: Text(option3),
                          onTap: () {
                            controller.text = option3;
                            Navigator.of(context).pop();
                          },
                        ),
                        if (option4 != null)
                          ListTile(
                            title: Text(option4!),
                            onTap: () {
                              controller.text = option4!;
                              Navigator.of(context).pop();
                            },
                          ),
                        if (option5 != null)
                          ListTile(
                            title: Text(option5!),
                            onTap: () {
                              controller.text = option5!;
                              Navigator.of(context).pop();
                            },
                          ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
