import 'package:flutter/material.dart';

import '../../../widgets/custom_titile.dart';

class MedicalReport extends StatelessWidget {
  const MedicalReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTitle(
          fontSize: 25,
          isAppbar: true,
          title: "Medical Report",
        ),
        leading: null,
      ),
      body: const Center(
        child: Text('Medical Report'),
      ),
    );
  }
}
