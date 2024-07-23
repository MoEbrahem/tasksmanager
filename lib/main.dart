import 'package:flutter/material.dart';
import 'package:tasksmanager/Home/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      initialRoute: HomeScreen.route_Name,
      routes: {
        HomeScreen.route_Name : (context)=>HomeScreen(),

      },
    );
  }
}