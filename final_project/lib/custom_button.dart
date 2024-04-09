import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double fontSize;
  final IconData? icon;
  final Color backGroundColor;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.width,
    required this.height,
    this.icon,
    required this.fontSize,
    required this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          
          backgroundColor: backGroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) // Conditionally include the icon
              Icon(
                icon,
                size: 20.0, // Adjust the size of the icon as needed
                color: Colors.white,
              ),
            SizedBox(width: Get.width * 0.02),
            Text(
              buttonText,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


