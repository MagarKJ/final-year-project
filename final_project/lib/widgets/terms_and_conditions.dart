import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsandCondition extends StatefulWidget {
  const TermsandCondition({super.key});

  @override
  State<TermsandCondition> createState() => _TermsandConditionState();
}

class _TermsandConditionState extends State<TermsandCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        title: const Text("Terms and Conditions"),
        titleSpacing: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: whiteColor,
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "1. Welcome to GetFit. By using our application, you agree to the following terms and conditions. Please read them carefully before using our services.\n"
          "2. Our app provides general health and fitness information, including a step counter and food recommendations for managing high and low blood pressure. This information is not a substitute for professional medical advice, diagnosis, or treatment. Always consult your doctor or a qualified healthcare provider before making any changes to your diet, exercise, or lifestyle based on the information provided by our app.\n"
          "3. Your privacy is important to us. We collect, store, and process your personal information, including health data such as steps counted and food preferences, in accordance with our Privacy Policy. By using this app, you consent to the collection and use of your data as outlined in our Privacy Policy.\n"
          "4. Our app includes a food recommendation system designed to assist users in managing their blood pressure. Recommendations are based on general guidelines and may not be suitable for everyone. The user assumes full responsibility for the choices made based on these recommendations.\n"
          "5. You are responsible for maintaining the security of your account, including keeping your login details confidential. We are not responsible for any loss or damage resulting from unauthorized access to your account.\n"
          "6. Our app may offer premium food recommendations, nutritional plans, and advanced data analytics, that requires one-time payment. Access to premium content is provided on a non-transferable, non-exclusive basis. The app reserves the right to modify or discontinue premium content at any time.\n"
          "7. The step counter feature is intended to help users track their physical activity. Accuracy may vary based on the device used, and the app does not guarantee the precise measurement of steps or calories burned.\n"
          "8. We reserve the right to modify or update these terms and conditions at any time. Users will be notified of any significant changes via email or through the app. Continued use of the app after such modifications constitutes acceptance of the revised terms.\n"
          "9. We reserve the right to suspend or terminate your access to the app at our sole discretion, without notice, for conduct that we believe violates these terms and conditions or is harmful to other users of the app, us, or third parties.\n"
          "10. These terms and conditions are governed by the laws. Any disputes arising from or related to these terms shall be subject to the exclusive jurisdiction of the courts.\n"
          "11. Any disputes or claims arising out of these terms or your use of the app shall be resolved through binding arbitration in accordance with the rules of organization. You agree to waive any right to a trial by jury or to participate in a class action.\n"
          "12. The app is provided 'as is' without any warranties, either express or implied. We do not guarantee that the app will be error-free, secure, or available at all times.\n"
          "13. If you have any questions, concerns, or need assistance with the app, please contact us at the given email. We are here to help and ensure that you have a positive experience with our app.",
          style: TextStyle(fontSize: 16.0, height: 1.5),
        ),
      ),
    );
  }
}
