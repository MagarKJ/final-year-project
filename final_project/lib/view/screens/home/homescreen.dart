import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/controller/apis/firebase_api.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/view/screens/home/notification.dart';
import 'package:final_project/view/screens/home/nutrition.dart';
import 'package:final_project/view/screens/home/step_counter2.dart';
import 'package:final_project/widgets/custom_titile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/bloc/home/home_page_bloc.dart';

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
    super.initState();
    fireBaseAPi.requestNotificationPermission();
    fireBaseAPi.getDeviceToken();
    fireBaseAPi.isTokenRefresh();
    fireBaseAPi.firebaseInit(context);
    fireBaseAPi.setupInteractMessage(context);
    _loadUserName();
    _loadUserNameFromGoogle();
  }

//FIrebase bata user ko name load garne
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
    //greeting ma kei na aaye null aauxa
    String greeting = '';
    String greetingAnimation;

// time anusar greeting message display garne
    if (currentTime.hour < 12) {
      LottieBuilder.asset(goodMorning);
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
      if (state is HomePageLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<HomePageBloc>(context).add(HomePageLoadEvent());
        },
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: 200,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_active_outlined),
                onPressed: () {
                  Get.to(() => const Notifications());
                },
              ),
              SizedBox(width: 10),
            ],
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  LottieBuilder.asset(
                    greetingAnimation,
                    repeat: false,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text("Add Meals"),
                      ),
                    ],
                  ),
                  const ListTile(
                    title: Text('Breakfast'),
                    subtitle: Text('2 eggs, 1 bread, 1 cup of tea'),
                    trailing: Text('200 cal'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
