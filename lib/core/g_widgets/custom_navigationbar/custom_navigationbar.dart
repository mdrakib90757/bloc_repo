import 'package:flutter/material.dart';
import 'package:serialman_app/feature/home/screen/home_screen.dart';
import 'package:serialman_app/feature/service_center/screen/service_center_screen.dart';

import '../../../feature/profile/screen/profile_screen.dart';
import '../../constansts/app_colors.dart';

class custom_navigationbar extends StatefulWidget {
  custom_navigationbar({super.key});

  @override
  State<custom_navigationbar> createState() => _custom_navigationbarState();
}

class _custom_navigationbarState extends State<custom_navigationbar> {
  int _currentIndex = 0;
  final List<Widget> _screen = [
    HomeScreen(),
    serviceCenterScreen(),
    serviceCenterScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 3),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: Colors.grey.shade400,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          elevation: 5.0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 33),
              activeIcon: Icon(Icons.home, size: 33),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.corporate_fare_outlined, size: 33),
              activeIcon: Icon(Icons.corporate_fare_rounded, size: 33),
              label: "Service-Center",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined, size: 33),
              activeIcon: Icon(Icons.category, size: 33),
              label: "Service-Types",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined, size: 33),
              activeIcon: Icon(Icons.settings, size: 33),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
