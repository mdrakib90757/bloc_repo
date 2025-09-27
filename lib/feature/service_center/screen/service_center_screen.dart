import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serialman_app/core/constansts/app_colors.dart';

import '../../../core/g_widgets/custom_clip_path_clipper/custom_clip_path_clipper.dart';

class serviceCenterScreen extends StatefulWidget {
  const serviceCenterScreen({super.key});

  @override
  State<serviceCenterScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<serviceCenterScreen> {
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'ServiceCenter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add, color: AppColor.primaryColor),
                              Text(
                                "Add",
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("data"),
                                Text("data"),
                                Text("data"),
                              ],
                            ),
                          ),
                        );
                      },
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
