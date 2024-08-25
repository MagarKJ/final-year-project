import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/apis/api.dart';
import '../../../controller/bloc/addFood/add_food_bloc.dart';
import '../../../controller/bloc/home/home_page_bloc.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/constants.dart';

class FoodDescription extends StatefulWidget {
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
  final String volume;
  final bool isToRemove;
  final bool isPremiumFood;
  final int isDrink;
  const FoodDescription(
      {super.key,
      required this.image,
      required this.foodId,
      required this.name,
      required this.ammount,
      required this.description,
      required this.calories,
      required this.carbs,
      required this.protein,
      required this.fat,
      required this.sodium,
      required this.volume,
      required this.isDrink,
      this.isToRemove = false,
      this.isPremiumFood = false});

  @override
  State<FoodDescription> createState() => _FoodDescriptionState();
}

class _FoodDescriptionState extends State<FoodDescription> {
  TextEditingController quantityController = TextEditingController();
  int counter = 1;
  bool okPressed = false;
  int diastolic = 0;
  int systolic = 0;
  double caloriesPerGram = 0.0;
  double carbsPerGram = 0.0;
  double proteinPerGram = 0.0;
  double fatPerGram = 0.0;
  double sodiumPerGram = 0.0;
  double volumePerGram = 0.0;
  String recomendation = '';

  Map<String, double> convertToPerGram({
    required double amount, // in grams
    required double calories, // total calories for the given amount
    required double carbs, // total carbs for the given amount (in grams)
    required double protein, // total protein for the given amount (in grams)
    required double fat, // total fat for the given amount (in grams)
    required double sodium, // total sodium for the given amount (in mg)
    required double volume,
  }) {
    // Calculate values per 1 gram of food
    double caloriesPerGram = calories / amount;
    double carbsPerGram = carbs / amount;
    double proteinPerGram = protein / amount;
    double fatPerGram = fat / amount;
    double sodiumPerGram = sodium / amount;
    double volumePerGram = volume / amount;

    // Return a map containing all the values per 1 gram
    return {
      'caloriesPerGram': caloriesPerGram,
      'carbsPerGram': carbsPerGram,
      'proteinPerGram': proteinPerGram,
      'fatPerGram': fatPerGram,
      'sodiumPerGram': sodiumPerGram,
      'volumePerGram': volumePerGram,
    };
  }

  List<int> splitBloodPressure(String bloodPressure) {
    // Split the input string by '/'
    List<String> parts = bloodPressure.split('/');

    // Convert the split parts to integers
    int systolic = int.parse(parts[0]);
    int diastolic = int.parse(parts[1]);

    // Return the values as a list
    return [systolic, diastolic];
  }

  String isFoodRecommended({
    required double calorieContent,
    required double carbContent,
    required double sodiumContent, // in mg

    required double fatContent, // in grams
  }) {
    // Define thresholds for blood pressure and sugar levels
    const double highSystolicBP = 130.0;
    const double highDiastolicBP = 80.0;
    const double highSugarLevel = 120.0;

    // Define nutrient thresholds

    const double maxSodium = 0.6; // Maximum recommended sodium per 1 gram in mg
    const double maxFat = 0.03; // Maximum recommended fat per 1 gram in grams
    const double maxCarb =
        0.1; // Maximum recommended carbohydrate per 1 gram in grams
    const double maxCalories =
        4.0; // Maximum recommended calorie intake per 1 gram in kcal

    // Check if blood pressure is high
    bool isHighBP = systolic > highSystolicBP || diastolic > highDiastolicBP;

    // Check if sugar level is high
    bool isHighSugarLevel = double.parse(bloodSugar) > highSugarLevel;

    // Check if food is high in sodium, sugar, or fat
    bool isHighSodium = sodiumContent > maxSodium;

    bool isHighFat = fatContent > maxFat;
    bool isHighCarb = carbContent > maxCarb;
    bool isHighCalories = calorieContent > maxCalories;

    // Determine if the food is recommended
    // If the user has high BP or high sugar levels, recommend food low in sodium, sugar, and fat
    if (isHighBP && (isHighSodium || isHighFat)) {
      return 'Not Recomended Because of your high Pressure';
    }
    if (isHighSugarLevel && (isHighCarb || isHighCalories)) {
      return 'Not Recomended Because of your high sugar levels';
    }

    // If none of the conditions are met, the food is recommended
    return 'Recomended';
  }

  @override
  void initState() {
    List<int> values = splitBloodPressure(bloodPressure);
    systolic = values[0];
    diastolic = values[1];

    print('Systolic: ${values[0]}');
    print('Diastolic: ${values[1]}');
    log('ammlount ${widget.ammount}');
    Map<String, double> perGramValues = convertToPerGram(
      amount: double.parse(widget.ammount),
      calories: double.parse(widget.calories),
      carbs: double.parse(widget.carbs),
      protein: double.parse(widget.protein),
      fat: double.parse(widget.fat),
      sodium: double.parse(widget.sodium),
      volume: double.parse(widget.volume),
    );

    recomendation = isFoodRecommended(
      calorieContent: perGramValues['caloriesPerGram'] ?? 0,
      carbContent: perGramValues['carbsPerGram'] ?? 0,
      sodiumContent: perGramValues['proteinPerGram'] ?? 0,
      fatContent: perGramValues['fatPerGram'] ?? 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        title: const Text(
          'Food Description',
        ),
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          widget.isPremiumFood == true
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8),
                  child: Align(
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
                          'DELETE',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          quantityController.text == ''
              ? setState(() {
                  okPressed = false;
                })
              : null;
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
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
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
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
                  'Ammount ${widget.ammount} ${widget.isDrink == 1 ? 'ml' : 'gram'}',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                  ),
                ),
                Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(
                      children: [
                        Text(
                          '  Calories',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          okPressed == false
                              ? ' ${widget.calories} kcal'
                              : ' ${caloriesPerGram.toStringAsFixed(2)} kcal',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      children: [
                        Text(
                          '  Carbs',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          okPressed == false
                              ? ' ${widget.carbs} gram'
                              : ' ${carbsPerGram.toStringAsFixed(2)} gram',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(
                          '  Protein',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          okPressed == false
                              ? ' ${widget.protein} gram'
                              : ' ${proteinPerGram.toStringAsFixed(2)} gram',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(
                          '  Fat',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          okPressed == false
                              ? ' ${widget.fat} gram'
                              : ' ${fatPerGram.toStringAsFixed(2)} gram',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(
                          '  Sodium',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          okPressed == false
                              ? ' ${widget.sodium} milg'
                              : ' ${sodiumPerGram.toStringAsFixed(2)} milg',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(
                          '  Volume',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          okPressed == false
                              ? ' ${widget.volume} ltr'
                              : ' ${volumePerGram.toStringAsFixed(2)} ltr',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: recomendation == 'Recomended'
                          ? Colors.green
                          : Colors.red,
                    )),
                    child: Text(
                      'Note: $recomendation',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: recomendation == 'Recomended'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: quantityController,
                        hintText:
                            'Enter the quantity in ${widget.isDrink == 1 ? 'ml' : 'gram'}',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: secondaryColor,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Map<String, double> perGramValues = convertToPerGram(
                            amount: double.parse(widget.ammount),
                            calories: double.parse(widget.calories),
                            carbs: double.parse(widget.carbs),
                            protein: double.parse(widget.protein),
                            fat: double.parse(widget.fat),
                            sodium: double.parse(widget.sodium),
                            volume: double.parse(widget.volume),
                          );
                          caloriesPerGram =
                              double.parse(quantityController.text) *
                                  perGramValues['caloriesPerGram']!;
                          carbsPerGram = double.parse(quantityController.text) *
                              perGramValues['carbsPerGram']!;
                          proteinPerGram =
                              double.parse(quantityController.text) *
                                  perGramValues['proteinPerGram']!;
                          fatPerGram = double.parse(quantityController.text) *
                              perGramValues['fatPerGram']!;
                          sodiumPerGram =
                              double.parse(quantityController.text) *
                                  perGramValues['sodiumPerGram']!;
                          volumePerGram =
                              double.parse(quantityController.text) *
                                  perGramValues['volumePerGram']!;
                          setState(() {
                            okPressed = true;
                          });
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(height: 10),
                widget.isToRemove == false
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
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
                                      foodCalories: okPressed == false
                                          ? widget.calories
                                          : caloriesPerGram.toStringAsFixed(2),
                                      foodCarbs: okPressed == false
                                          ? widget.carbs
                                          : carbsPerGram.toStringAsFixed(2),
                                      foodProtein: okPressed == false
                                          ? widget.protein
                                          : proteinPerGram.toStringAsFixed(2),
                                      foodFat: okPressed == false
                                          ? widget.fat
                                          : fatPerGram.toStringAsFixed(2),
                                      foodSodium: okPressed == false
                                          ? widget.sodium
                                          : sodiumPerGram.toStringAsFixed(2),
                                      image: widget.image,
                                    ));
                                  }
                                  widget.isPremiumFood == true
                                      ? BlocProvider.of<AddFoodBloc>(context)
                                          .add(AddFoodLoadedEvent(
                                              url1: '/api/customs/$userId'))
                                      : BlocProvider.of<AddFoodBloc>(context)
                                          .add(AddFoodLoadedEvent(
                                              url: '/api/meals'));

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
                        ),
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
                      ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// class FoodData {
//   String name;
//   double totalWeight; // in grams
//   double calories;
//   double carbs;
//   double fat;

//   FoodData({
//     required this.name,
//     required this.totalWeight,
//     required this.calories,
//     required this.carbs,
//     required this.fat,
//   });
// }

// Map<String, double> calculatePerGram(FoodData foodData) {
//   double perGramCalories = foodData.calories / foodData.totalWeight;
//   double perGramCarbs = foodData.carbs / foodData.totalWeight;
//   double perGramFat = foodData.fat / foodData.totalWeight;

//   return {
//     'calories': perGramCalories,
//     'carbs': perGramCarbs,
//     'fat': perGramFat,
//   };
// }

// void main() {
//   FoodData potato = FoodData(
//     name: 'Potato',
//     totalWeight: 86.0,
//     calories: 80.50,
//     carbs: 18.50,
//     fat: 0.1,
//   );

//   Map<String, double> potatoPerGram = calculatePerGram(potato);

//   print('Per gram of ${potato.name}:');
//   print('Calories: ${potatoPerGram['calories']}');
//   print('Carbs: ${potatoPerGram['carbs']}');
//   print('Fat: ${potatoPerGram['fat']}');
// }
