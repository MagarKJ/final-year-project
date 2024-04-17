import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/bloc/home/home_page_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';

  @override
  void initState() {
    super.initState();
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

// time anusar greeting message display garne
    if (currentTime.hour < 12) {
      greeting = 'Good Morning';
    } else if (currentTime.hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }
    return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
      if (state is HomePageLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Scaffold(
        appBar: AppBar(
          leadingWidth: 200,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_active_outlined),
              onPressed: () {},
            ),
          ],
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage(userProfile),
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
        // baki code yeha lekhnee
      );
    });
  }
}
