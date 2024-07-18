import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/screens/home/note_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_titile.dart';

class MedicalReport extends StatelessWidget {
  const MedicalReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        title: const CustomTitle(
          fontSize: 25,
          isAppbar: true,
          title: "Medical Report",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => PillReminder());
            },
            icon: const Icon(Icons.alarm),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        leading: null,
      ),
      body: const Center(
        child: Text('Medical Report'),
      ),
    );
  }
}
