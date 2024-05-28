import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Nutritions extends StatefulWidget {
  const Nutritions({super.key});

  @override
  State<Nutritions> createState() => _NutritionsState();
}

class _NutritionsState extends State<Nutritions> {
  @override
  Widget build(BuildContext context) {
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
                      percent: 0.4,
                      progressColor: Colors.black,
                      curve: Curves.easeInOut,
                      animation: true,
                      center: const Text('40%'),
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
                          percent: 0.4,
                          progressColor: waterColor,
                          curve: Curves.easeInOut,
                          animation: true,
                          center: const Text(
                            '40%',
                            style: TextStyle(color: Colors.white),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        SizedBox(width: 10),
                        Container(
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
                          percent: 0.8,
                          progressColor: waterColor,
                          curve: Curves.easeInOut,
                          animation: true,
                          center: const Text(
                            '80%',
                            style: TextStyle(color: Colors.white),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
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
                          percent: 0.6,
                          progressColor: waterColor,
                          curve: Curves.easeInOut,
                          animation: true,
                          center: const Text(
                            '60%',
                            style: TextStyle(color: Colors.white),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
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
                        const Text('2.5 liters'),
                        const SizedBox(height: 15),
                        LinearPercentIndicator(
                          percent: 0.8,
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
