import 'dart:developer';
import 'dart:io';

import 'package:final_project/utils/constants.dart';
import 'package:final_project/utils/global_variables.dart';
import 'package:final_project/view/screens/medicalreport/pill_reminder.dart';
import 'package:final_project/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/custom_titile.dart';

class MedicalReport extends StatefulWidget {
  const MedicalReport({super.key});

  @override
  State<MedicalReport> createState() => _MedicalReportState();
}

class _MedicalReportState extends State<MedicalReport> {
  XFile? selectedFile;
  bool isPhotoUploaded = false;
  final TextEditingController _bloodPressureController =
      TextEditingController();

  final TextEditingController _sugarLevelController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _bloodPressureController.text = bloodPressure;
      _sugarLevelController.text = bloodSugar;
    });
    super.initState();
  }

  @override
  void dispose() {
    _bloodPressureController.dispose();
    _sugarLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: const CustomTitle(
          fontSize: 25,
          isAppbar: true,
          title: "Medical Report",
        ),
        leading: null,
      ),
      body: _buildUi(),
    );
  }

  Widget _buildUi() {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Information',
                style: GoogleFonts.inter(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Blood Pressure',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                      ),
                    ),
                    CustomTextField(
                      controller: _bloodPressureController,
                      prefixIcon: Icons.bloodtype,
                      hintText: "",
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your blood pressure';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sugar Level',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                      ),
                    ),
                    CustomTextField(
                      controller: _sugarLevelController,
                      prefixIcon: Icons.bloodtype,
                      hintText: "",
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your blood pressure';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  onTap: () {
                    // const RemoteMessage dummyMessage = RemoteMessage(
                    //   notification: RemoteNotification(
                    //     title: 'Test Notification',
                    //     body: 'This is a test notification body',
                    //     android: AndroidNotification(
                    //       channelId: 'default_channel',
                    //     ),
                    //   ),
                    //   data: {'key1': 'value1', 'key2': 'value2'},
                    // );

                    Get.to(() => PillReminder());
                    // FireBaseAPi firebase = FireBaseAPi();
                    // firebase.showNotification(dummyMessage);
                  },
                  leading: const Icon(
                    Icons.alarm,
                    color: Colors.blue,
                    size: 40,
                  ),
                  title: const Text('Set Reminder'),
                  subtitle: const Text(
                      'Will be set according to Time and date mentioned'),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Medical Reports',
                style: GoogleFonts.inter(
                  fontSize: 20,
                ),
              ),
              isPhotoUploaded == true ? _imageView() : const SizedBox.shrink(),
              isPhotoUploaded == true
                  ? _extractTextView()
                  : const SizedBox.shrink(),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton.icon(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final data = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 100,
                    );
                    setState(() {
                      selectedFile = data;
                      isPhotoUploaded = true;
                    });
                  },
                  label: const Text('Add Medical Report'),
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageView() {
    return SizedBox(
      child: selectedFile != null
          ? Center(
              child: Image.file(
                File(
                  selectedFile!.path,
                ),
              ),
            )
          : const Center(
              child: Text("Pick Image"),
            ),
    );
  }

  Widget _extractTextView() {
    if (selectedFile == null) {
      return const Text("No Result");
    }
    return FutureBuilder(
        future: extractText(
          File(
            selectedFile!.path,
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.toString());
          } else if (snapshot.hasError) {
            log(snapshot.error.toString());
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          } else {
            return const Text("No Result");
          }
        });
  }

  Future<String?> extractText(File file) async {
    final textRecognixer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognixer.processImage(inputImage);
    String text = recognizedText.text;
    print(recognizedText.text);
    textRecognixer.close();
    return text;
  }
}
