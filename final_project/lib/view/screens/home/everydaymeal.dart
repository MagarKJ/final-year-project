import 'dart:developer';

import 'package:final_project/controller/bloc/home/home_page_bloc.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/screens/addfood/addfood_shimmer.dart';
import 'package:final_project/view/screens/addfood/food_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Everydaymeal extends StatefulWidget {
  const Everydaymeal({super.key});

  @override
  State<Everydaymeal> createState() => _AddFoodState();
}

class _AddFoodState extends State<Everydaymeal> {
  @override
  void initState() {
    BlocProvider.of<HomePageBloc>(context).add(HomePageLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Daily Meals'),
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: primaryColor.withOpacity(0.8),
            ),
            child: TextButton(
              onPressed: () {
                BlocProvider.of<HomePageBloc>(context)
                    .add(RemoveAllMealsEvent());
                Fluttertoast.showToast(msg: 'All Your Daily Meal Is Deleted');
                BlocProvider.of<HomePageBloc>(context).add(HomePageLoadEvent());
              },
              child: Text(
                'Delete All',
                style: GoogleFonts.inter(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state is HomePageInitial) {
            log(state.toString());
            BlocProvider.of<HomePageBloc>(context).add(HomePageLoadEvent());
          } else if (state is HomePageLoadingState) {
            log(state.toString());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomePageLoadedState) {
            log(state.allProduct.toString());
            log(state.toString());
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<HomePageBloc>(context).add(HomePageLoadEvent());
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.allProduct.isEmpty
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
                                    image: 'image',
                                    name: state.allProduct[index].name,
                                    ammount: 'per 100 grams',
                                    description:
                                        state.allProduct[index].description,
                                    calories: state.allProduct[index].calories,
                                    carbs: state.allProduct[index].carbs,
                                    protein: state.allProduct[index].protein,
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
                                  trailing: IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<HomePageBloc>(context)
                                            .add(RemoveSpecificFoodEvent(
                                          foodID: state.allProduct[index].id,
                                        ));
                                        BlocProvider.of<HomePageBloc>(context)
                                            .add(HomePageLoadEvent());
                                      },
                                      color: myBlue),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            );
          }
          return const AddFoodShimmer();
        },
      ),
    );
  }
}