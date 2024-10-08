// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/controller/apis/api.dart';
import 'package:final_project/controller/bloc/addFood/add_food_bloc.dart';
import 'package:final_project/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/bloc/home/home_page_bloc.dart';
import '../../../utils/constants.dart';

class FoodDesc extends StatefulWidget {
  final String image;
  final int foodId;
  final String name;
  final String ammount;
  final String description;
  final String calories;
  final String carbs;
  final String protein;
  final String fat;
  final String sodium;
  final bool isToRemove;
  final bool isPremiumFood;
  const FoodDesc({
    super.key,
    required this.foodId,
    required this.image,
    required this.name,
    required this.ammount,
    required this.description,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.sodium,
    this.isToRemove = false,
    this.isPremiumFood = false,
  });

  @override
  State<FoodDesc> createState() => _FoodDescState();
}

class _FoodDescState extends State<FoodDesc> {
  int counter = 1;

  @override
  void initState() {
    // TODO: implement initState
    // log('$imageBaseUrl/meal-photos/${widget.image}');
    log(widget.image);
    log(widget.foodId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Stack(
        children: [
          Container(
            width: Get.width * 0.8,
            child: Column(
              children: [
                widget.image == 'null'
                    ? Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            getFirstandLastNameInitals(
                                widget.name.toString().toUpperCase()),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                          ),
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: widget.isPremiumFood
                            ? '$imageBaseUrl/custom-photos/${widget.image}'
                            : '$imageBaseUrl/meal-photos/${widget.image}',
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: Get.height * 0.2,
                            decoration: BoxDecoration(
                              // color: Colors.amber,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          );
                        },
                      ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -15,
            top: -15,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.description,
            style: GoogleFonts.inter(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Nutritional facts',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Ammount ${widget.ammount}',
            style: GoogleFonts.inter(
              fontSize: 18,
            ),
          ),
          Table(
            children: [
              TableRow(
                children: [
                  Text(
                    'Calories',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.calories,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    'Carbs',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.carbs,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    'Protein',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.protein,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    'Fat',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.fat,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    'Sodium',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.sodium,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          widget.isPremiumFood == true
              ? Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: Get.height * 0.05,
                    // width: Get.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<AddFoodBloc>(context).add(
                            DeletePremiumFoodEvent(
                                foodId: widget.foodId.toString()));
                        BlocProvider.of<AddFoodBloc>(context).add(
                            AddFoodLoadedEvent(url1: '/api/customs/$userId'));

                        Navigator.pop(context);
                      },
                      child: Text(
                        'DELETE FOOD',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 10),
          widget.isToRemove == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.green),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (counter > 1) {
                                  counter--;
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Text(
                          '$counter',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 27),
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.green),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                counter++;
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: Get.height * 0.05,
                      width: Get.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          for (int i = 0; i < counter; i++) {
                            BlocProvider.of<AddFoodBloc>(context)
                                .add(AddFoodButtonPressedEvent(
                              foodName: widget.name,
                              foodDescription: widget.description,
                              foodCalories: widget.calories,
                              foodCarbs: widget.carbs,
                              foodProtein: widget.protein,
                              foodFat: widget.fat,
                              foodSodium: widget.sodium,
                              image: widget.image,
                            ));
                          }
                          BlocProvider.of<AddFoodBloc>(context)
                              .add(AddFoodLoadedEvent(url: '/api/meals'));

                          Navigator.pop(context);
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
                  ],
                )
              : Center(
                  child: Container(
                    height: Get.height * 0.05,
                    // width: Get.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<HomePageBloc>(context)
                            .add(RemoveSpecificFoodEvent(
                          foodID: widget.foodId,
                        ));
                        BlocProvider.of<HomePageBloc>(context)
                            .add(HomePageLoadEvent());

                        Navigator.pop(context);
                      },
                      child: Text(
                        'REMOVE FOOD',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

void showFoodDesc({
  required context,
  required int foodId,
  required String image,
  required String name,
  required String ammount,
  required String description,
  required String calories,
  required String carbs,
  required String protein,
  required String fat,
  required String sodium,
  bool isToRemove = false,
  bool isPremiumFood = false,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FoodDesc(
        foodId: foodId,
        image: image,
        name: name,
        ammount: ammount,
        description: description,
        calories: calories,
        carbs: carbs,
        protein: protein,
        fat: fat,
        sodium: sodium,
        isToRemove: isToRemove,
        isPremiumFood: isPremiumFood,
      );
    },
  );
}
