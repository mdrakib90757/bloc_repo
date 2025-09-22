import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serialman_app/core/constansts/app_colors.dart';
import 'package:serialman_app/core/utils/date_formatter.dart';

import '../../../core/g_widgets/custom_clip_path_clipper/custom_clip_path_clipper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateFormatter _dateFormatter = DateFormatter();
  final DateTime _today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (AppColor.primaryColor),
        title: Text(
          "SerialMan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actionsPadding: EdgeInsets.only(right: 10),
        actions: [
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 20),
          Icon(Icons.logout, color: Colors.white),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: ClipPathClipper(),
              child: Container(
                color: const Color(0xFF316984), // Match the blue in the image
                height: 250,
                width: double.maxFinite,
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
              ),
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Islami Bank Hospital Mirpur',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            DateFormat("EEEE,d MMMM yyyy").format(_today),
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
