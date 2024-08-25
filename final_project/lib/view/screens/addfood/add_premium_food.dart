import 'dart:developer';
import 'dart:io';

import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/bloc/addFood/add_food_bloc.dart';
import '../../../utils/global_variables.dart';
import '../../../widgets/custom_text_field.dart';

class AddPremiumFood extends StatefulWidget {
  const AddPremiumFood({super.key});

  @override
  State<AddPremiumFood> createState() => _AddPremiumFoodState();
}

class _AddPremiumFoodState extends State<AddPremiumFood> {
  XFile? file;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController carbsController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController fatController = TextEditingController();
  TextEditingController sodiumController = TextEditingController();
  TextEditingController volumeController = TextEditingController();
  TextEditingController qualityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<String> type = [
    "Food",
    "Drink",
  ];
  String? selectType;
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    caloriesController.dispose();
    carbsController.dispose();
    proteinController.dispose();
    fatController.dispose();
    sodiumController.dispose();
    volumeController.dispose();
    qualityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        surfaceTintColor: whiteColor,
        titleSpacing: 0,
        title: Text(
          'Add Premium Food',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: Get.width * 0.9,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      CustomTextField(
                        controller: nameController,
                        hintText: 'Food Name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a food name';
                          }
                          return null;
                        },
                      ),
                      Text('Description',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      CustomTextField(
                        controller: descriptionController,
                        hintText: 'Food Description',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 8),
                        child: DropdownButton<String>(
                          dropdownColor: whiteColor,
                          borderRadius: BorderRadius.circular(15),
                          hint: Text(
                            "Select type",
                            style: TextStyle(fontFamily: 'inter', color: black),
                          ),
                          value: selectType,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectType = newValue;
                            });
                          },
                          autofocus: true,
                          items: type.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Text('Quantity',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      CustomTextField(
                        controller: qualityController,
                        hintText:
                            'Quantity in ${selectType == 'Drink' ? 'ml' : 'gm'}',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a food calories';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      Text('Calories',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      CustomTextField(
                        controller: caloriesController,
                        hintText: 'Food Calories',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a food calories';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      Text(
                        'Carbohydrates',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomTextField(
                        controller: carbsController,
                        hintText: 'Food Carbs',
                        keyboardType: TextInputType.number,
                      ),
                      Text('Protein',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      CustomTextField(
                        controller: proteinController,
                        hintText: 'Food Protein',
                        keyboardType: TextInputType.number,
                      ),
                      Text('Fats',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      CustomTextField(
                        controller: fatController,
                        hintText: 'Food Fats',
                        keyboardType: TextInputType.number,
                      ),
                      Text('Sodium',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      CustomTextField(
                        controller: sodiumController,
                        hintText: 'Food Sodium',
                        keyboardType: TextInputType.number,
                      ),
                      Text('Volume',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      CustomTextField(
                        controller: volumeController,
                        hintText: 'Food Volume',
                        keyboardType: TextInputType.number,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey,
                              ),
                              onPressed: () async {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 100,
                                );
                                setState(() {
                                  file = pickedFile;
                                });
                              },
                              child: Text(
                                'Pick An Image',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            if (file != null)
                              Image.file(
                                File(file!.path),
                                height: 80,
                                width: 80,
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              log('message');
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AddFoodBloc>(context).add(
                                  AddPremiumFoodButtonPressedEvent(
                                    foodName: nameController.text,
                                    description: descriptionController.text,
                                    foodCalories: caloriesController.text,
                                    foodCarbs: carbsController.text,
                                    foodProtein: proteinController.text,
                                    foodFat: fatController.text,
                                    foodSodium: sodiumController.text,
                                    volume: volumeController.text,
                                    image: file,
                                    quality: qualityController.text,
                                    type: selectType == 'Drink' ? 1 : 0,
                                  ),
                                );

                                BlocProvider.of<AddFoodBloc>(context).add(
                                    AddFoodLoadedEvent(
                                        url1: '/api/customs/$userId'));

                                Navigator.pop(context);
                                log('message2');
                              }
                            },
                            child: Text(
                              'ADD FOOD',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
