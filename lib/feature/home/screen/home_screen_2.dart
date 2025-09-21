import 'package:flutter/material.dart';
import 'package:serialman_app/feature/home/screen/home_screen.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: Center(
        child: Column(
          children: [
            Text("WELCOME HOME SCREEN"),
            TextButton(onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => PostScreen(),));
            }, child: Text("Go to Post Screen"))
          ],
        ),
      )
    );
  }
}
