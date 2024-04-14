import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/bloc/home/home_page_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
      if (state is HomePageLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return homePageWidget(context, state);
    });
  }

  Widget homePageWidget(BuildContext context, HomePageState loadedstate) {
    final currentTime = DateTime.now();
    //greeting ma kei na aaye null aauxa
    String greeting = '';

// time anusar greeting message display garne
    if (currentTime.hour < 12) {
      greeting = 'Good Morning';
    } else if (currentTime.hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evining';
    }
    return FutureBuilder(
      //user ko data lyauna lai ho bloc bata garxu alik din maa yo sikhna lai gareko ho
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          
          var name = snapshot.data?.getString('name');
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
                      backgroundImage: AssetImage('assets/logo/apple.png'),
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
                          '$name',
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
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
