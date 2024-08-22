import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/screens/profile/payemnt/esewa.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Go Premium'),
      ),
      body: Column(
        children: [
          
          ElevatedButton(
            onPressed: () {
              Esewa esewa = Esewa();
              esewa.pay();
            },
            child: const Text('Pay with Esewa'),
          ),
        ],
      ),
    );
  }
}
