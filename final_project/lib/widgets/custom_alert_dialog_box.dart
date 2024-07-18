import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../utils/constants.dart';

void customAlertBox(
  context,
  String content,
  String button1Text,
  void Function()? ontap1,
  String button2Text,
  void Function()? ontap2,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 10,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        actionsAlignment: button1Text == ''
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        contentTextStyle: GoogleFonts.inter(
          color: secondaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        content: Text(content),
        actions: <Widget>[
          button1Text == ''
              ? const SizedBox.shrink()
              : Container(
                  width: Get.width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: secondaryColor,
                        width: 1,
                      )),
                  child: TextButton(
                    onPressed: ontap1,
                    child: Text(
                      button1Text,
                      style: GoogleFonts.inter(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
          Container(
            width: button1Text == '' ? Get.width * 0.9 : Get.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: secondaryColor,
            ),
            child: TextButton(
              onPressed: ontap2,
              child: Text(
                button2Text,
                style: GoogleFonts.inter(
                  color: whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

void customAlertBox2(
  BuildContext context,
  String mainText,
  String content,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 10,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentTextStyle: GoogleFonts.inter(
          color: Colors.grey,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        title: Row(
          children: [
            Text(
              mainText,
              style: const TextStyle(
                color: Color(0xff54595E),
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Color(0xffE5E5E5),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close, size: 18),
                  ),
                ),
              ),
            )
          ],
        ),
        content: Row(
          children: [
            Row(
              children: [
                Text(content),
              ],
            ),
          ],
        ),
      );
    },
  );
}
