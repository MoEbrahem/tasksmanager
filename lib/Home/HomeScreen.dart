// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasksmanager/auth/login.dart';
import 'package:tasksmanager/constants/AppColor.dart';
import 'package:tasksmanager/Home/settings.dart';
import 'package:tasksmanager/provider/provider.dart';
import 'package:tasksmanager/widgets/bottomSheet.dart';
import 'package:tasksmanager/Home/taskListTab.dart';

class HomeScreen extends StatefulWidget {
  static const route_Name = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = [TaskListTab(), Settings()];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryLightColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Text(
            "Tasks Manager",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              provider.tasksList = [];
              Navigator.of(context).pushReplacementNamed(Login.route_Name);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(
          iconSize: 30,
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
        onPressed: onfloatingButtonClick,
        child: const Icon(
          Icons.add,
          color: AppColor.whiteColor,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 30,
            color: AppColor.primaryLightColor,
          ),
          Expanded(
            child: screens[currentIndex],
          ),
        ],
      ),
    );
  }

  onfloatingButtonClick() {
    return showModalBottomSheet(
      context: context,
      builder: (context) => ShowBottomSheetItems(),
    );
  }
}
