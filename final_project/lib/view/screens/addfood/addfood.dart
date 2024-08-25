import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/utils/global_variables.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/screens/addfood/add_premium_food.dart';
import 'package:final_project/view/screens/addfood/addfood_shimmer.dart';
import 'package:final_project/view/screens/addfood/food_desc.dart';
import 'package:final_project/view/screens/addfood/food_details.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../controller/apis/api.dart';
import '../../../controller/bloc/addFood/add_food_bloc.dart';
import '../../../widgets/custom_titile.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  int selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  int? groupVal;
  int diastolic = 0;
  int systolic = 0;

  bool isFoodRecommended({
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
      return false;
    }
    if (isHighSugarLevel && (isHighCarb || isHighCalories)) {
      return false;
    }

    // If none of the conditions are met, the food is recommended
    return true;
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

  Map<String, double> convertToPerGram({
    required double amount, // in grams
    required double calories, // total calories for the given amount
    required double carbs, // total carbs for the given amount (in grams)
    required double protein, // total protein for the given amount (in grams)
    required double fat, // total fat for the given amount (in grams)
    required double sodium, // total sodium for the given amount (in mg)
  }) {
    // Calculate values per 1 gram of food
    double caloriesPerGram = calories / amount;
    double carbsPerGram = carbs / amount;
    double proteinPerGram = protein / amount;
    double fatPerGram = fat / amount;
    double sodiumPerGram = sodium / amount;

    // Return a map containing all the values per 1 gram
    return {
      'caloriesPerGram': caloriesPerGram,
      'carbsPerGram': carbsPerGram,
      'proteinPerGram': proteinPerGram,
      'fatPerGram': fatPerGram,
      'sodiumPerGram': sodiumPerGram,
    };
  }

  @override
  void initState() {
    List<int> values = splitBloodPressure(bloodPressure);
    systolic = values[0];
    diastolic = values[1];

    print('Systolic: ${values[0]}');
    print('Diastolic: ${values[1]}');

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        selectedIndex == 0
            ? BlocProvider.of<AddFoodBloc>(context)
                .add(AddFoodLoadedEvent(url: '/api/meals'))
            : BlocProvider.of<AddFoodBloc>(context)
                .add(AddFoodLoadedEvent(url1: '/api/customs/$userId'));
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            surfaceTintColor: whiteColor,
            automaticallyImplyLeading: false,
            backgroundColor: whiteColor,
            title: const CustomTitle(
              fontSize: 25,
              isAppbar: true,
              title: "Add Food",
            ),
            leading: null,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: TextFormField(
                    autofocus: false,
                    controller: _searchController,
                    onChanged: (val) {
                      if (val.isEmpty) {
                        _searchController.clear();
                        selectedIndex == 0
                            ? BlocProvider.of<AddFoodBloc>(context)
                                .add(AddFoodLoadedEvent(url: '/api/meals'))
                            : BlocProvider.of<AddFoodBloc>(context).add(
                                AddFoodLoadedEvent(
                                    url1: '/api/customs/$userId'));
                      } else {
                        selectedIndex == 0
                            ? BlocProvider.of<AddFoodBloc>(context).add(
                                AddFoodLoadedEvent(
                                  url: '/api/meals?searchKey=$val',
                                ),
                              )
                            : BlocProvider.of<AddFoodBloc>(context).add(
                                AddFoodLoadedEvent(
                                  url1: '/api/customs/$userId?searchKey=$val',
                                ),
                              );
                      }
                    },
                    onFieldSubmitted: (val) {
                      val == ''
                          ? {
                              _searchController.clear(),
                              selectedIndex == 0
                                  ? BlocProvider.of<AddFoodBloc>(context).add(
                                      AddFoodLoadedEvent(url: '/api/meals'))
                                  : BlocProvider.of<AddFoodBloc>(context).add(
                                      AddFoodLoadedEvent(
                                          url1: '/api/customs/$userId')),
                              FocusScope.of(context).unfocus(),
                            }
                          : {
                              FocusScope.of(context).unfocus(),
                              selectedIndex == 0
                                  ? BlocProvider.of<AddFoodBloc>(context).add(
                                      AddFoodLoadedEvent(
                                          url: '/api/meals?searchKey=$val'),
                                    )
                                  : BlocProvider.of<AddFoodBloc>(context).add(
                                      AddFoodLoadedEvent(
                                        url1:
                                            '/api/customs/$userId?searchKey=$val',
                                      ),
                                    ),
                            };
                    },
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: secondaryColor,
                      ),
                      hintText: 'Search Food By Title',
                      hintStyle: TextStyle(
                        color: myGrey,
                        fontSize: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: secondaryColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color:
                              secondaryColor, // this is the border color when focused
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 20),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          selectedIndex == 0
                              ? BlocProvider.of<AddFoodBloc>(context)
                                  .add(AddFoodLoadedEvent(url: '/api/meals'))
                              : BlocProvider.of<AddFoodBloc>(context).add(
                                  AddFoodLoadedEvent(
                                      url1: 'api/customs/$userId'));
                          _searchController.clear();
                        },
                        child: _searchController.text.isNotEmpty &&
                                _searchController.text != ''
                            ? const Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 20,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  )),
            ),
            actions: [
              selectedIndex == 1
                  ? IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Get.to(() => AddPremiumFood());
                      },
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: BlocBuilder<AddFoodBloc, AddFoodState>(
            builder: (context, state) {
              if (state is AddFoodInitial) {
                selectedIndex == 0
                    ? BlocProvider.of<AddFoodBloc>(context)
                        .add(AddFoodLoadedEvent(url: '/api/meals'))
                    : BlocProvider.of<AddFoodBloc>(context)
                        .add(AddFoodLoadedEvent(url1: '/api/customs/$userId'));
              } else if (state is AddFoodLoadingState) {
                log('$state');
                return const AddFoodShimmer();
              } else if (state is AddFoodErrorState) {
                log('$state');
                return Center(
                  child: Text(state.message),
                );
              } else if (state is AddFoodLoadedState) {
                log('$state');
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: isPremium == 1
                            ? MainAxisAlignment.spaceAround
                            : MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 0;
                                log('Selected Index: $selectedIndex');
                              });
                            },
                            child: Padding(
                              padding: isPremium == 1
                                  ? const EdgeInsets.all(0.0)
                                  : const EdgeInsets.only(left: 10),
                              child: Container(
                                decoration: isPremium == 1
                                    ? selectedIndex == 0
                                        ? BoxDecoration(
                                            border: BorderDirectional(
                                              bottom: BorderSide(
                                                color: secondaryColor,
                                                width: 2,
                                              ),
                                            ),
                                          )
                                        : null
                                    : null,
                                child: Text('All Foods',
                                    style: TextStyle(
                                        fontSize: selectedIndex == 0 ? 20 : 16,
                                        color: selectedIndex == 0
                                            ? secondaryColor
                                            : Colors.black)),
                              ),
                            ),
                          ),
                          isPremium == 1
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = 1;
                                      log('Selected Index: $selectedIndex');
                                    });
                                    BlocProvider.of<AddFoodBloc>(context).add(
                                        AddFoodLoadedEvent(
                                            url1: '/api/customs/$userId'));
                                  },
                                  child: Container(
                                    decoration: selectedIndex == 1
                                        ? BoxDecoration(
                                            border: BorderDirectional(
                                              bottom: BorderSide(
                                                color: secondaryColor,
                                                width: 2,
                                              ),
                                            ),
                                          )
                                        : null,
                                    child: Text('Premium Foods',
                                        style: TextStyle(
                                            fontSize:
                                                selectedIndex == 1 ? 20 : 16,
                                            color: selectedIndex == 1
                                                ? secondaryColor
                                                : Colors.black)),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      selectedIndex == 0
                          ? state.allProduct.isEmpty
                              ? const Center(
                                  child: Text('No data found'),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.allProduct.length,
                                  itemBuilder: (context, index) {
                                    Map<String, double> perGramValues =
                                        convertToPerGram(
                                      amount: double.parse(
                                          state.allProduct[index].ammount),
                                      calories: double.parse(
                                          state.allProduct[index].calories),
                                      carbs: double.parse(
                                          state.allProduct[index].carbs),
                                      protein: double.parse(
                                          state.allProduct[index].protein),
                                      fat: double.parse(
                                          state.allProduct[index].fats),
                                      sodium: double.parse(
                                          state.allProduct[index].sodium),
                                    );

                                    bool recommended = isFoodRecommended(
                                      calorieContent:
                                          perGramValues['caloriesPerGram'] ?? 0,
                                      carbContent:
                                          perGramValues['carbsPerGram'] ?? 0,
                                      sodiumContent:
                                          perGramValues['proteinPerGram'] ?? 0,
                                      fatContent:
                                          perGramValues['fatPerGram'] ?? 0,
                                    );
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => FoodDescription(
                                            foodId: int.tryParse(state
                                                .allProduct[index].id
                                                .toString())!,
                                            image: state.allProduct[index]
                                                    .imageUrl ??
                                                '',
                                            name: state.allProduct[index].name,
                                            ammount:
                                                state.allProduct[index].ammount,
                                            description: state
                                                .allProduct[index].description,
                                            calories: state
                                                .allProduct[index].calories,
                                            carbs:
                                                state.allProduct[index].carbs,
                                            protein:
                                                state.allProduct[index].protein,
                                            fat: state.allProduct[index].fats,
                                            sodium:
                                                state.allProduct[index].sodium,
                                            volume: state
                                                    .allProduct[index].volume ??
                                                '',
                                            isDrink:
                                                state.allProduct[index].drink,
                                          ),
                                        );
                                      },
                                      child: ListTile(
                                          leading: SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: state.allProduct[index]
                                                        .imageUrl ==
                                                    'null'
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    child: Text(
                                                      getFirstandLastNameInitals(
                                                          state
                                                              .allProduct[index]
                                                              .name
                                                              .toString()
                                                              .toUpperCase()),
                                                      style: TextStyle(
                                                          color: whiteColor,
                                                          fontSize: 16),
                                                    ),
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        '$imageBaseUrl/meal-photos/${state.allProduct[index].imageUrl}',
                                                    imageBuilder: (context,
                                                        imageProvider) {
                                                      return Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: Colors.amber,
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit
                                                                .fitHeight,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    placeholder:
                                                        (context, url) {
                                                      return Image.asset(
                                                        'assets/no_food.jpeg',
                                                        fit: BoxFit.fitHeight,
                                                      );
                                                    },
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      'assets/no_food.jpeg',
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                          ),
                                          title: Container(
                                            // color: Colors.amber,
                                            width: Get.width * 0.5,
                                            child: Text(
                                              state.allProduct[index].name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          subtitle: Text(
                                            'Calories: ${state.allProduct[index].calories.toString()}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: calorieColor),
                                          ),
                                          trailing: recommended == true
                                              ? const Icon(
                                                  Icons.thumb_up,
                                                  color: Colors.green,
                                                )
                                              : const Icon(
                                                  Icons.thumb_down,
                                                  color: Colors.red,
                                                )),
                                    );
                                  },
                                )
                          : state.premiumFood.isEmpty
                              ? const Center(
                                  child: Text('No data found'),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.premiumFood.length,
                                  itemBuilder: (context, index) {
                                    Map<String, double> perGramValues =
                                        convertToPerGram(
                                      amount: double.parse(
                                          state.premiumFood[index].ammount),
                                      calories: double.parse(
                                          state.allProduct[index].calories),
                                      carbs: double.parse(
                                          state.allProduct[index].carbs),
                                      protein: double.parse(
                                          state.allProduct[index].protein),
                                      fat: double.parse(
                                          state.allProduct[index].fats),
                                      sodium: double.parse(
                                          state.allProduct[index].sodium),
                                    );

                                    bool recommended = isFoodRecommended(
                                      calorieContent:
                                          perGramValues['caloriesPerGram'] ?? 0,
                                      carbContent:
                                          perGramValues['carbsPerGram'] ?? 0,
                                      sodiumContent:
                                          perGramValues['proteinPerGram'] ?? 0,
                                      fatContent:
                                          perGramValues['fatPerGram'] ?? 0,
                                    );
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => FoodDescription(
                                            foodId: int.tryParse(state
                                                .premiumFood[index].id
                                                .toString())!,
                                            image: state.premiumFood[index]
                                                    .imageUrl ??
                                                '',
                                            name: state.premiumFood[index].name,
                                            ammount: state
                                                .premiumFood[index].ammount,
                                            description: state
                                                .premiumFood[index].description,
                                            calories: state
                                                .premiumFood[index].calories,
                                            carbs:
                                                state.premiumFood[index].carbs,
                                            protein: state
                                                .premiumFood[index].protein,
                                            fat: state.premiumFood[index].fats,
                                            sodium:
                                                state.premiumFood[index].sodium,
                                            volume: state.premiumFood[index]
                                                    .volume ??
                                                '',
                                            isPremiumFood: true,
                                            isDrink:
                                                state.premiumFood[index].drink,
                                          ),
                                        );
                                      },
                                      child: ListTile(
                                        leading: SizedBox(
                                          height: 60,
                                          width: 60,
                                          child: state.premiumFood[index]
                                                      .imageUrl ==
                                                  'null'
                                              ? Text('data')
                                              // ? CircleAvatar(
                                              //     backgroundColor: Colors.green,
                                              //     child: Text(
                                              //       getFirstandLastNameInitals(
                                              //           state.premiumFood[index]
                                              //               .name
                                              //               .toString()
                                              //               .toUpperCase()),
                                              //       style: TextStyle(
                                              //           color: whiteColor,
                                              //           fontSize: 16),
                                              //     ),
                                              //   )
                                              : CachedNetworkImage(
                                                  imageUrl:
                                                      '$imageBaseUrl/custom-photos/${state.premiumFood[index].imageUrl}',
                                                  imageBuilder:
                                                      (context, imageProvider) {
                                                    return Container(
                                                      height: 60,
                                                      width: 60,
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
                                                  placeholder: (context, url) {
                                                    return Image.asset(
                                                      'assets/no_food.jpeg',
                                                      fit: BoxFit.fitHeight,
                                                    );
                                                  },
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    'assets/no_food.jpeg',
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                        ),
                                        title: Text(
                                          state.premiumFood[index].name,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          'Calories: ${state.premiumFood[index].calories.toString()}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: calorieColor),
                                        ),
                                        trailing: recommended == true
                                            ? const Icon(
                                                Icons.thumb_up,
                                                color: Colors.green,
                                              )
                                            : const Icon(
                                                Icons.thumb_down,
                                                color: Colors.red,
                                              ),
                                      ),
                                    );
                                  },
                                ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
