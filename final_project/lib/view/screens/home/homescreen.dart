import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/utils/global_variables.dart';
import 'package:final_project/view/screens/home/everydaymeal.dart';
import 'package:final_project/view/screens/home/notification.dart';
import 'package:final_project/view/screens/home/nutrition.dart';
import 'package:final_project/view/screens/home/step_counter2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/apis/api.dart';
import '../../../controller/apis/firebase_api.dart';
import '../../../controller/bloc/home/home_page_bloc.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_titile.dart';
import '../addfood/food_desc.dart';
import '../addfood/food_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FireBaseAPi fireBaseAPi = FireBaseAPi();

  @override
  void initState() {
    log('homepageinit state');
    log('$token');
    log('$userId');
    log('$token');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    String greeting = '';
    String greetingAnimation;

    if (currentTime.hour < 12) {
      greeting = 'Good Morning';
      greetingAnimation = goodMorning;
    } else if (currentTime.hour < 18) {
      greeting = 'Good Afternoon';
      greetingAnimation = goodAfternoon;
    } else {
      greeting = 'Good Evening';
      greetingAnimation = goodEvening;
    }

    return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
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
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: whiteColor,
              appBar: AppBar(
                titleSpacing: 0,
                leadingWidth: 70,
                backgroundColor: whiteColor,
                surfaceTintColor: whiteColor,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_active_outlined),
                    onPressed: () {
                      Get.to(() => const Notifications());
                    },
                  ),
                  const SizedBox(width: 10),
                ],
                title: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        greeting,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        name ?? 'User',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: LottieBuilder.asset(
                    greetingAnimation,
                    // repeat: false,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTitle(
                        title: 'Activity',
                        fontSize: 25,
                      ),
                      Nutritions(nutrients: state.nutrients[0]),
                      isPremium == 1
                          ? const CustomTitle(
                              title: 'Step Counter',
                              fontSize: 25,
                            )
                          : const SizedBox.shrink(),
                      isPremium == 1
                          ? const StepCounter2()
                          : const SizedBox.shrink(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomTitle(
                            fontSize: 25,
                            title: "Today's Food",
                          ),
                          state.allProduct.length > 4
                              ? TextButton(
                                  onPressed: () {
                                    log('add food');
                                    Get.offAll(() => const Everydaymeal());
                                  },
                                  child: const Text("See All"),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      state.allProduct.isEmpty
                          ? const Center(
                              child: Text('No data found'),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.allProduct.length > 4
                                  ? 4
                                  : state.allProduct.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => FoodDescription(
                                        foodId: int.tryParse(state
                                            .allProduct[index].id
                                            .toString())!,
                                        image:
                                            state.allProduct[index].imageUrl ??
                                                '',
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
                                        isToRemove: true,
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    leading: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: state.allProduct[index].imageUrl ==
                                              'null'
                                          ? CircleAvatar(
                                              backgroundColor: Colors.green,
                                              child: Text(
                                                getFirstandLastNameInitals(state
                                                    .allProduct[index].name
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
                                        icon: Icon(
                                          Icons.remove_circle_outline,
                                          color: myBlue,
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
              ),
            ),
          ),
        );
      } else if (state is HomePageErrorState) {
        log(state.toString());
        log(state.message.toString());
        return Center(
          child: Text('${state.message} Please try again'),
        );
      }
      return const SizedBox();
    });
  }
}
