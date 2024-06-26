import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/view/bottom_navigtion_bar.dart';
import 'package:final_project/view/screens/addfood/addfood.dart';
import 'package:final_project/view/screens/home/notification.dart';
import 'package:final_project/view/screens/home/nutrition.dart';
import 'package:final_project/view/screens/home/step_counter2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/apis/firebase_api.dart';
import '../../../controller/bloc/home/home_page_bloc.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_titile.dart';
import '../addfood/food_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';

  FireBaseAPi fireBaseAPi = FireBaseAPi();

  @override
  void initState() {
    log('homepageinit state');
    super.initState();
    fireBaseAPi.requestNotificationPermission();
    fireBaseAPi.getDeviceToken();
    fireBaseAPi.isTokenRefresh();
    fireBaseAPi.firebaseInit(context);
    fireBaseAPi.setupInteractMessage(context);
    _loadUserName();
    _loadUserNameFromGoogle();
  }

  Future<void> _loadUserName() async {
    User? currenyUser = FirebaseAuth.instance.currentUser;
    if (currenyUser != null) {
      DocumentSnapshot userName = await FirebaseFirestore.instance
          .collection('users')
          .doc(currenyUser.uid)
          .get();
      if (userName.exists) {
        setState(() {
          name = userName['name'];
        });
      } else {
        name = '';
      }
    }
  }

  Future<void> _loadUserNameFromGoogle() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      if (currentUser.displayName != null) {
        setState(() {
          name = currentUser.displayName!;
        });
      } else {
        name = '';
      }
    }
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
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              leadingWidth: 200,
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
              leading: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    LottieBuilder.asset(
                      greetingAnimation,
                      // repeat: false,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          greeting,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
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
                    const Nutritions(),
                    const CustomTitle(
                      title: 'Step Counter',
                      fontSize: 25,
                    ),
                    const StepCounter2(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomTitle(
                          fontSize: 25,
                          title: "Today's Food",
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Get.to(() => MyBottomNavigationBar(
                                  currentIndex: 2,
                                ));
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Add Meals"),
                        ),
                      ],
                    ),
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
                                  trailing: Icon(Icons.add_circle_outline,
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
        );
      } else if (state is HomePageErrorState) {
        log(state.toString());
        log(state.message.toString());
        return Center(
          child: Text(state.message + ' Please try again'),
        );
      }
      return const SizedBox();
    });
  }
}
