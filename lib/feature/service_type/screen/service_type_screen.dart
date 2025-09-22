import 'package:flutter/material.dart';

class serviceTypeScreen extends StatefulWidget {
  const serviceTypeScreen({super.key});

  @override
  State<serviceTypeScreen> createState() => _serviceTypeScreenState();
}

class _serviceTypeScreenState extends State<serviceTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text("ServiceType screen")),
    );
  }
}
