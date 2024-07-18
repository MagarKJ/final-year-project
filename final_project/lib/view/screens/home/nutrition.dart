import 'dart:developer';

import 'package:final_project/utils/constants.dart';
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

  double convertToFractionForCarbs(double value, double totalValue) {
    log('carbs ${widget.nutrients.totalCarbs.toString()}');
    return (value / totalValue);
  }

  double convertToFractionForWater(double value, double totalValue) {
    log('water ${widget.nutrients.totalVolume.toString()}');
    return (value / totalValue);
  }

  @override
  Widget build(BuildContext context) {
    double calorieFraction = convertToFractionForCalories(
        double.parse(widget.nutrients.totalCalories), 1000);

    double proteinFraction = convertToFractionForProtein(
        double.parse(widget.nutrients.totalProtein), 100);

    double fatsFraction =
        convertToFractionForFats(double.parse(widget.nutrients.totalFats), 100);

    double carbsFraction = convertToFractionForCarbs(
        double.parse(widget.nutrients.totalCarbs), 1000);

    double waterFraction = convertToFractionForWater(
        double.parse(widget.nutrients.totalVolume), 3);

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
                                  style: const TextStyle(
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
                          percent: carbsFraction > 1 ? 1 : carbsFraction,
                          progressColor: waterColor,
                          curve: Curves.easeInOut,
                          animation: true,
                          center: carbsFraction > 1
                              ? const Text(
                                  '100 %',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                )
                              : Text(
                                  '${(carbsFraction * 100).toStringAsFixed(2)} %',
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
                            'Carbs',
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
                        Text('${widget.nutrients.totalVolume} liters'),
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
                            Text('Sleep'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.bedtime),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Text('5 hours'),
                        const SizedBox(height: 15),
                        LinearPercentIndicator(
                          percent: 0.5,
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
