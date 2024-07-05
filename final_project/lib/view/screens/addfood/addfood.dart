import 'dart:developer';

import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/screens/addfood/addfood_shimmer.dart';
import 'package:final_project/view/screens/addfood/food_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/bloc/addFood/add_food_bloc.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
 
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddFoodBloc>(context).add(AddFoodLoadedEvent());
  
  }

 

 

  

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<AddFoodBloc>(context).add(AddFoodLoadedEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Food'),
        ),
        body: BlocBuilder<AddFoodBloc, AddFoodState>(
          builder: (context, state) {
            if (state is AddFoodInitial) {
              log('$state');
              BlocProvider.of<AddFoodBloc>(context).add(AddFoodLoadedEvent());
              return const Center(
                child: CircularProgressIndicator(),
              );
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 0;
                              log('Selected Index: $selectedIndex');
                            });
                          },
                          child: Text('All Foods',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: selectedIndex == 0
                                      ? myBlue
                                      : Colors.black)),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 1;
                              log('Selected Index: $selectedIndex');
                            });
                          },
                          child: Text('Premium Foods',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: selectedIndex == 1
                                      ? myBlue
                                      : Colors.black)),
                        ),
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
                                  return GestureDetector(
                                    onTap: () {
                                      showFoodDesc(
                                        context: context,
                                        foodId: int.tryParse(state
                                            .allProduct[index].id
                                            .toString())!,
                                        image: 'image',
                                        name: state.allProduct[index].name,
                                        ammount: 'per 100 grams',
                                        description:
                                            state.allProduct[index].description,
                                        calories:
                                            state.allProduct[index].calories,
                                        carbs: state.allProduct[index].carbs,
                                        protein:
                                            state.allProduct[index].protein,
                                        fat: state.allProduct[index].fats,
                                        sodium: state.allProduct[index].sodium,
                                      );
                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Text(
                                          getFirstandLastNameInitals(state
                                              .allProduct[index].name
                                              .toString()
                                              .toUpperCase()),
                                          style: TextStyle(
                                              color: whiteColor, fontSize: 16),
                                        ),
                                      ),
                                      title: Text(
                                        state.allProduct[index].name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        'Calories: ${state.allProduct[index].calories.toString()}',
                                        style: TextStyle(
                                            fontSize: 14, color: calorieColor),
                                      ),
                                      trailing: Icon(Icons.add_circle_outline,
                                          color: myBlue),
                                    ),
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
                                  return GestureDetector(
                                    onTap: () {
                                      showFoodDesc(
                                        context: context,
                                        foodId: int.tryParse(state
                                            .allProduct[index].id
                                            .toString())!,
                                        image: 'image',
                                        name: state.premiumFood[index].name,
                                        ammount: 'per 100 grams',
                                        description: state
                                            .premiumFood[index].description,
                                        calories:
                                            state.premiumFood[index].calories,
                                        carbs: state.premiumFood[index].carbs,
                                        protein:
                                            state.premiumFood[index].protein,
                                        fat: state.premiumFood[index].fats,
                                        sodium: state.premiumFood[index].sodium,
                                      );
                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Text(
                                          getFirstandLastNameInitals(state
                                              .allProduct[index].name
                                              .toString()
                                              .toUpperCase()),
                                          style: TextStyle(
                                              color: whiteColor, fontSize: 16),
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
                                            fontSize: 14, color: calorieColor),
                                      ),
                                      trailing: Icon(Icons.add_circle_outline,
                                          color: myBlue),
                                    ),
                                  );
                                },
                              ),
                  ],
                ),
              );
            }
            return const AddFoodShimmer();
          },
        ),
      ),
    );
  }
}
