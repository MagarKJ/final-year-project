import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final String hintText;
  final bool obscureText;
  final bool? showPassword;
  final ValueChanged<bool>? onTogglePassword;
  final TextInputType keyboardType;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.hintText,
    this.obscureText = false,
    this.showPassword,
    this.onTogglePassword,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.0645,
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText && !(showPassword ?? false),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(3),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: myGrey),
            borderRadius: BorderRadius.circular(3),
          ),
          prefixIcon: Icon(prefixIcon, color: myGrey),
          suffixIcon: obscureText
              ? IconButton(
                  onPressed: () {
                    onTogglePassword?.call(!(showPassword ?? false));
                  },
                  icon: Icon(
                    showPassword ?? false
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: myGrey,
                  ),
                )
              : null,
          hintText: hintText,
          label: Text(hintText),
          labelStyle: GoogleFonts.montserrat(
            color: myGrey,
            fontSize: 11.43,
            fontWeight: FontWeight.w500,
          ),
          // floatingLabelAlignment: FloatingLabelAlignment.center,
          hintStyle: GoogleFonts.montserrat(
            color: myGrey,
            fontSize: 11.43,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
