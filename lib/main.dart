import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tasksmanager/Home/HomeScreen.dart';
import 'package:tasksmanager/constants/appThemeData.dart';
import 'package:tasksmanager/auth/login.dart';
import 'package:tasksmanager/auth/register.dart';
import 'package:tasksmanager/provider/authProvider.dart';
import 'package:tasksmanager/provider/provider.dart';
/////////////////// Hive ////////////////////

// Box? mybox;
// Future<Box> openHiveBox(String boxName) async {
//   if (!Hive.isBoxOpen(boxName)) {
//     Hive.init((await getApplicationDocumentsDirectory()).path);
//   }
//   return await Hive.openBox(boxName);
// }

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  // mybox = await openHiveBox("mohamed");
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

  // await FirebaseFirestore.instance.disableNetwork();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>MyProvider()),
      ChangeNotifierProvider(create: (_)=>Authprovider()),
    ],
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
      initialRoute: Register.route_Name,
      routes: {
        HomeScreen.route_Name: (context) => HomeScreen(),
        Register.route_Name: (context) => Register(),
        Login.route_Name: (context) => Login(),
      },
    );
  }
}
