import 'dart:developer';

import 'package:final_project/utils/constants.dart';
import 'package:final_project/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../model/nutrients_model.dart';

class Nutritions extends StatefulWidget {
  final NutrientsModel nutrients;
  const Nutritions({super.key, required this.nutrients});

  @override
  State<Nutritions> createState() => _NutritionsState();
}

class _NutritionsState extends State<Nutritions> {
  double dailyCalorie = 0.0;
  double dailyProtein = 0.0;
  double dailyFat = 0.0;
  double dailyWater = 0.0;
  double dailyCarbs = 0.0;
  double dailySodium = 0.0;
//make a function to convert nutrients to percentage
  double convertToFractionForProtein(double value, double totalValue) {
    log('protein ${widget.nutrients.totalProtein.toString()}');
    return (value / totalValue);
  }

  double convertToFractionForCalories(double value, double totalValue) {
    log('calories ${widget.nutrients.totalCalories.toString()}');
    return (value / totalValue);
  }

  double convertToFractionForFats(double value, double totalValue) {
    log('fats ${widget.nutrients.totalFats.toString()}');
    return (value / totalValue);
  }

  double convertToFractionForSodium(double value, double totalValue) {
    log('fats ${widget.nutrients.totalSodium.toString()}');
    return (value / totalValue);
  }

  double convertToFractionForCarbs(double value, double totalValue) {
    log('carbs ${widget.nutrients.totalCarbs.toString()}');
    return (value / totalValue);
  }

  double convertToFractionForWater(double value, double totalValue) {
    log('water ${widget.nutrients.totalVolume.toString()}');
    return (value / totalValue);
  }

  double calculateCalories() {
    double bmr;

    // BMR calculation using Harris-Benedict equation
    if (sex.toLowerCase() == 'male') {
      bmr = 88.362 +
          (13.397 * double.parse(weight)) +
          (4.799 * age) -
          (5.677 * age);
    } else {
      bmr = 447.593 +
          (9.247 * double.parse(weight)) +
          (3.098 * age) -
          (4.330 * age);
    }

    // Adjust BMR based on body type
    switch (bodytype.toLowerCase()) {
      case 'morbidly obese':
        bmr *= 1.1; // Increase calorie needs by 10%
        break;
      case 'obese':
        bmr *= 1.05; // Increase calorie needs by 5%
        break;
      case 'overweight':
        bmr *= 1.0; // No adjustment
        break;
      case 'average':
        bmr *= 1.05; // Increase calorie needs by 5%
        break;
      case 'lean': // Slim is interpreted as lean
        bmr *= 1.1; // Increase calorie needs by 10%
        break;
      default:
        bmr *= 1.0; // No adjustment
    }

    // Adjust BMR based on ethnicity
    switch (ethnicity.toLowerCase()) {
      case 'asian':
        bmr *= 1.0; // No adjustment
        break;
      case 'african':
        bmr *= 1.1; // Increase by 10%
        break;
      case 'hispanic':
        bmr *= 1.05; // Increase by 5%
        break;
      case 'caucasian':
        bmr *= 1.1; // Increase by 10%
        break;
      case 'others':
      default:
        bmr *= 1.0; // No adjustment
    }

    // Final adjustment to bring it closer to the average
    bmr *= 2.3; // Increase final calorie needs by 50%

    return bmr;
  }

  double calculateProtein() {
    double protein;

    // Basic protein requirement calculation
    // Start with 1.0 grams per kilogram of weight as a base
    protein = 1.0 * double.parse(weight);

    // Adjust protein needs based on body type
    switch (bodytype.toLowerCase()) {
      case 'morbidly obese':
        protein *= 1.0; // Maintain standard protein intake
        break;
      case 'obese':
        protein *= 1.05; // Slightly increase protein intake
        break;
      case 'overweight':
        protein *= 1.1; // Increase protein intake
        break;
      case 'average':
        protein *= 1.1; // Slightly increase protein intake
        break;
      case 'lean': // Slim is interpreted as lean
        protein *= 1.15; // Moderate protein intake increase
        break;
      default:
        protein *= 1.0; // No adjustment
    }

    // Adjust protein needs based on ethnicity
    switch (ethnicity.toLowerCase()) {
      case 'asian':
        protein *= 1.0; // No adjustment
        break;
      case 'african':
        protein *= 1.05; // Increase by 5%
        break;
      case 'hispanic':
        protein *= 1.05; // Increase by 5%
        break;
      case 'caucasian':
        protein *= 1.1; // Increase by 10%
        break;
      case 'others':
      default:
        protein *= 1.0; // No adjustment
    }

    // Final adjustment to bring it closer to a more typical range
    protein *= 1.1; // Slightly increase final protein needs

    return protein;
  }

  double calculateFat() {
    double fat;

    // Basic fat requirement calculation
    // Start with 0.8 grams per kilogram of weight as a base
    fat = 0.8 * double.parse(weight);

    // Adjust fat needs based on body type
    switch (bodytype.toLowerCase()) {
      case 'morbidly obese':
        fat *= 0.9; // Decrease fat intake
        break;
      case 'obese':
        fat *= 0.95; // Slightly decrease fat intake
        break;
      case 'overweight':
        fat *= 1.0; // No adjustment
        break;
      case 'average':
        fat *= 1.05; // Slightly increase fat intake
        break;
      case 'lean': // Slim is interpreted as lean
        fat *= 1.1; // Moderate fat intake increase
        break;
      default:
        fat *= 1.0; // No adjustment
    }

    // Adjust fat needs based on ethnicity
    switch (ethnicity.toLowerCase()) {
      case 'asian':
        fat *= 0.95; // Slightly decrease fat intake
        break;
      case 'african':
        fat *= 1.1; // Increase by 10%
        break;
      case 'hispanic':
        fat *= 1.05; // Increase by 5%
        break;
      case 'caucasian':
        fat *= 1.1; // Increase by 10%
        break;
      case 'others':
      default:
        fat *= 1.0; // No adjustment
    }

    // Final adjustment to ensure the value is balanced
    fat *= 1.05; // Slightly increase final fat intake

    return fat;
  }

  double calculateCarbohydrate() {
    double carbs;

    // Basic carbohydrate requirement calculation
    // Start with 4 grams per kilogram of weight as a base
    carbs = 4.0 * double.parse(weight);

    // Adjust carbohydrate needs based on body type
    switch (bodytype.toLowerCase()) {
      case 'morbidly obese':
        carbs *= 0.9; // Decrease carbohydrate intake
        break;
      case 'obese':
        carbs *= 0.95; // Slightly decrease carbohydrate intake
        break;
      case 'overweight':
        carbs *= 1.0; // No adjustment
        break;
      case 'average':
        carbs *= 1.05; // Slightly increase carbohydrate intake
        break;
      case 'lean': // Slim is interpreted as lean
        carbs *= 1.1; // Moderate carbohydrate intake increase
        break;
      default:
        carbs *= 1.0; // No adjustment
    }

    // Adjust carbohydrate needs based on ethnicity
    switch (ethnicity.toLowerCase()) {
      case 'asian':
        carbs *= 1.1; // Increase by 10%
        break;
      case 'african':
        carbs *= 1.15; // Increase by 15%
        break;
      case 'hispanic':
        carbs *= 1.1; // Increase by 10%
        break;
      case 'caucasian':
        carbs *= 1.05; // Increase by 5%
        break;
      case 'others':
      default:
        carbs *= 1.0; // No adjustment
    }

    // Final adjustment to ensure the value is balanced
    carbs *= 1; // Slightly decrease final carbohydrate intake

    return carbs;
  }

  double calculateWaterIntake() {
    double water;

    // Basic water intake calculation
    // Start with 35 milliliters per kilogram of weight as a base
    water = 35.0 * double.parse(weight);

    // Adjust water intake based on body type
    switch (bodytype.toLowerCase()) {
      case 'morbidly obese':
        water *= 1.1; // Increase water intake
        break;
      case 'obese':
        water *= 1.05; // Slightly increase water intake
        break;
      case 'overweight':
        water *= 1.0; // No adjustment
        break;
      case 'average':
        water *= 1.05; // Slightly increase water intake
        break;
      case 'lean': // Slim is interpreted as lean
        water *= 1.1; // Increase water intake
        break;
      default:
        water *= 1.0; // No adjustment
    }

    // Adjust water intake based on ethnicity
    switch (ethnicity.toLowerCase()) {
      case 'asian':
        water *= 1.0; // No adjustment
        break;
      case 'african':
        water *= 1.05; // Increase by 5%
        break;
      case 'hispanic':
        water *= 1.0; // No adjustment
        break;
      case 'caucasian':
        water *= 1.05; // Increase by 5%
        break;
      case 'others':
      default:
        water *= 1.0; // No adjustment
    }

    // Final adjustment to ensure the value is balanced
    water *= 0.98; // Slightly decrease final water intake

    return water; // Water intake in milliliters
  }

  double calculateSodiumIntake() {
    double sodium;

    // Basic sodium intake calculation
    // Start with a base of 1500 milligrams per day, which is a common recommendation
    sodium = 1500.0;

    // Adjust sodium intake based on body type
    switch (bodytype.toLowerCase()) {
      case 'morbidly obese':
        sodium *= 1.1; // Increase sodium needs
        break;
      case 'obese':
        sodium *= 1.05; // Slightly increase sodium needs
        break;
      case 'overweight':
        sodium *= 1.0; // No adjustment
        break;
      case 'average':
        sodium *= 1.05; // Slightly increase sodium needs
        break;
      case 'lean': // Slim is interpreted as lean
        sodium *= 1.1; // Increase sodium needs
        break;
      default:
        sodium *= 1.0; // No adjustment
    }

    // Adjust sodium intake based on ethnicity
    switch (ethnicity.toLowerCase()) {
      case 'asian':
        sodium *= 0.95; // Slightly decrease sodium intake
        break;
      case 'african':
        sodium *= 1.1; // Increase sodium intake
        break;
      case 'hispanic':
        sodium *= 1.05; // Slightly increase sodium intake
        break;
      case 'caucasian':
        sodium *= 1.05; // Slightly increase sodium intake
        break;
      case 'others':
      default:
        sodium *= 1.0; // No adjustment
    }

    // Final adjustment to bring sodium intake to recommended levels
    sodium *= 0.95; // Slightly decrease final sodium intake

    return sodium; // Sodium intake in milligrams
  }

  @override
  void initState() {
    dailyCalorie = calculateCalories();
    dailyProtein = calculateProtein();
    dailyFat = calculateFat();
    dailyCarbs = calculateCarbohydrate();
    dailyWater = calculateWaterIntake();
    dailySodium = calculateSodiumIntake();
    log('daily calorie $dailyCalorie');
    log('daily protein $dailyProtein');
    log('daily Fat $dailyFat');
    log('daily Carbs $dailyCarbs');
    log('daily water $dailyWater');
    log('daily Soidum $dailySodium');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double calorieFraction = convertToFractionForCalories(
        double.parse(widget.nutrients.totalCalories), dailyCalorie);

    double proteinFraction = convertToFractionForProtein(
        double.parse(widget.nutrients.totalProtein), dailyProtein);

    double fatsFraction = convertToFractionForFats(
        double.parse(widget.nutrients.totalFats), dailyFat);
    double sodiumFraction = convertToFractionForFats(
        double.parse(widget.nutrients.totalSodium), dailySodium);

    double carbsFraction = convertToFractionForCarbs(
        double.parse(widget.nutrients.totalCarbs), dailyCarbs);

    double waterFraction = convertToFractionForWater(
        double.parse(widget.nutrients.totalVolume), dailyWater);

    return Column(
      children: [
        StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2.5,
              child: Container(
                decoration: BoxDecoration(
                  color: waterColorWithOpacity,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Calories'),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.local_fire_department)
                      ],
                    ),
                    const SizedBox(height: 15),
                    CircularPercentIndicator(
                      radius: 60,
                      lineWidth: 10,
                      percent: calorieFraction > 1 ? 1 : calorieFraction,
                      progressColor: Colors.black,
                      curve: Curves.easeInOut,
                      animation: true,
                      center: calorieFraction > 1
                          ? const Text('100 %')
                          : Text(
                              '${(calorieFraction * 100).toStringAsFixed(2)} %'),
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ],
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2.5,
              child: Container(
                decoration: BoxDecoration(
                  color: black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: 30,
                          lineWidth: 5,
                          percent: proteinFraction > 1 ? 1 : proteinFraction,
                          progressColor: waterColor,
                          curve: Curves.easeInOut,
                          animation: true,
                          center: proteinFraction > 1
                              ? const Text(
                                  '100 %',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                )
                              : Text(
                                  '${(proteinFraction * 100).toStringAsFixed(2)} %',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: Get.width * 0.15,
                          // color: Colors.amber,
                          child: const Text(
                            'Protein',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: 30,
                          lineWidth: 5,
                          percent: fatsFraction > 1 ? 1 : fatsFraction,
                          progressColor: waterColor,
                          curve: Curves.easeInOut,
                          animation: true,
                          center: fatsFraction > 1
                              ? const Text(
                                  '100 %',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                )
                              : Text(
                                  '${(fatsFraction * 100).toStringAsFixed(2)} %',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: Get.width * 0.15,
                          child: const Text(
                            'Fats',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: 30,
                          lineWidth: 5,
                          percent: sodiumFraction > 1 ? 1 : sodiumFraction,
                          progressColor: waterColor,
                          curve: Curves.easeInOut,
                          animation: true,
                          center: sodiumFraction > 1
                              ? const Text(
                                  '100 %',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                )
                              : Text(
                                  '${(sodiumFraction * 100).toStringAsFixed(2)} %',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: Get.width * 0.15,
                          child: const Text(
                            'Sodium',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1.1,
              child: Container(
                decoration: BoxDecoration(
                  color: greenWithOpasity,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Water'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.water_drop),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text('${widget.nutrients.totalVolume} mL'),
                        const SizedBox(height: 15),
                        LinearPercentIndicator(
                          percent: waterFraction > 1 ? 1 : waterFraction,
                          progressColor: Colors.white,
                          backgroundColor: Colors.black,
                          lineHeight: 10,
                          animation: true,
                          animationDuration: 1000,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1.1,
              child: Container(
                decoration: BoxDecoration(
                  color: sleepColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Carbs'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.lunch_dining),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text('${widget.nutrients.totalVolume} Cal'),
                        const SizedBox(height: 15),
                        LinearPercentIndicator(
                          percent: carbsFraction > 1 ? 1 : carbsFraction,
                          progressColor: Colors.white,
                          backgroundColor: Colors.black,
                          lineHeight: 10,
                          animation: true,
                          animationDuration: 1000,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
