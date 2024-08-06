import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasksmanager/constants/AppColor.dart';
import 'package:tasksmanager/provider/provider.dart';

class ThemeModeBottomSheet extends StatefulWidget {
  const ThemeModeBottomSheet({super.key});

  @override
  State<ThemeModeBottomSheet> createState() => _ThemeModeBottomSheetState();
}

class _ThemeModeBottomSheetState extends State<ThemeModeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var provider = Provider.of<MyProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          provider.appThemeMode == ThemeMode.light
              ? selectedItem("Light")
              : unSelectedItem(
                  "Light",
                  provider,
                  ThemeMode.light,
                ),
          const SizedBox(
            height: 15,
          ),
          provider.appThemeMode == ThemeMode.dark
              ? selectedItem("Dark")
              : unSelectedItem(
                  "Dark",
                  provider,
                  ThemeMode.dark,
                ),
        ],
      ),
    );
  }

  Widget selectedItem(String theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          theme,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Icon(
          Icons.check,
          color: AppColor.primaryLightColor,
        ),
      ],
    );
  }

  Widget unSelectedItem(String theme, MyProvider provider, ThemeMode newTheme) {
    return InkWell(
      onTap: () {
        provider.changeThemeMode(newTheme);
        Navigator.pop(context);
        setState(() {});
      },
      child: Text(
        theme,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
