import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:final_project/controller/bloc/home/home_page_bloc.dart';
import 'package:final_project/view/screens/addfood/addfood.dart';
import 'package:final_project/view/screens/analytics/analytics.dart';
import 'package:final_project/view/screens/home/homescreen.dart';
import 'package:final_project/view/screens/medicalreport/medicalreport.dart';
import 'package:final_project/view/screens/profile/profile.dart';

class MyBottomNavigationBar extends StatefulWidget {
  int? currentIndex;
  MyBottomNavigationBar({
    super.key,
    this.currentIndex,
  });

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  final List<Widget> _pages = [
    BlocProvider(
      create: (context) => HomePageBloc(),
      child: const HomeScreen(),
    ),
    const MedicalReport(),
    const AddFood(),
    const Analytics(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    int? _selectedIndex =
        (widget.currentIndex == null) ? 0 : widget.currentIndex;
    return Scaffold(
      body: _pages[_selectedIndex!],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information_outlined),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
            ),
            label: 'Add Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
