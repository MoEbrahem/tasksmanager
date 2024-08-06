import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasksmanager/provider/provider.dart';
import 'package:tasksmanager/widgets/languagesList.dart';
import 'package:tasksmanager/widgets/themeModeBottomSheet.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              ItemList(
                textBox: "English",
                title: "Language",
                ontap: () {},
              ),
              ItemList(
                textBox: provider.appThemeMode==ThemeMode.light?"Light":"Dark",
                title: "Mode",
                ontap: () {
                  showBottomThemeModeBar();
                },
              ),
            ],
          )),
    );
  }

  void showBottomThemeModeBar() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const ThemeModeBottomSheet();
      },
    );
  }
}
