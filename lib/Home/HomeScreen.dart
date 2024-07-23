import 'package:flutter/material.dart';
import 'package:tasksmanager/AppColor.dart';
import 'package:tasksmanager/Home/listsTasks.dart';
import 'package:tasksmanager/Home/settings.dart';

class HomeScreen extends StatefulWidget {
  static const route_Name = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = [const ListTasks(), const Settings()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryLightColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: Text(
            "Tasks Manager",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "List",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "settings",
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          
          color: AppColor.whiteColor,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppColor.primaryLightColor,
            height: 50,
          ),
          Expanded(
            child: screens[currentIndex],
          ),
        ],
      ),
    );
  }
}
