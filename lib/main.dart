import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasksmanager/Home/HomeScreen.dart';
import 'package:tasksmanager/appThemeData.dart';
import 'package:tasksmanager/provider.dart';
import 'package:tasksmanager/widgets/editTask.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyA1bQXg8SUs4mR9KOzEsFiRN6tcgIZZ71k",
            appId: "com.example.tasksmanager",
            messagingSenderId: "171213334629",
            projectId: "todo-tasks-manager-767df",
          ),
        )
      : await Firebase.initializeApp();

  await FirebaseFirestore.instance.disableNetwork();

  runApp(
    ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: provider.appThemeMode == ThemeMode.light ? LightTheme : DarkTheme,
      themeMode: provider.appThemeMode,
      initialRoute: HomeScreen.route_Name,
      routes: {
        HomeScreen.route_Name: (context) => HomeScreen(),
        
      },
    );
  }
}
