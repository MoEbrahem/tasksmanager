import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasksmanager/AppColor.dart';
import 'package:tasksmanager/firebase_utils.dart';
import 'package:tasksmanager/model/TaskModel.dart';
import 'package:tasksmanager/provider.dart';

class ShowBottomSheetItems extends StatefulWidget {
  @override
  State<ShowBottomSheetItems> createState() => _ShowBottomSheetItemsState();
}

class _ShowBottomSheetItemsState extends State<ShowBottomSheetItems> {
  // DateTime timeOfDay = DateTime.now();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late MyProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyProvider>(context);

    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      child: Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add new Task",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColor.textColor),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            TextFormField(
              controller: title,
              keyboardType: TextInputType.text,
              style: Theme.of(context).textTheme.titleSmall,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Task Title";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter Task Title",
                hintStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            TextFormField(
              maxLines: 3,
              controller: desc,
              keyboardType: TextInputType.text,
              style: Theme.of(context).textTheme.titleSmall,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Type a Describtion";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter Describtion",
                hintStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              "Select Date",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColor.textColor),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            InkWell(
              onTap: () {
                showDateTime();
              },
              child: Text(
                '${provider.selectedDate.day}/${provider.selectedDate.month}/${provider.selectedDate.year}',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColor.hintText),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            IconButton(
              style: const ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(AppColor.primaryLightColor),
              ),
              onPressed: () {
                AddTask();
              },
              icon: const Icon(
                Icons.done,
                color: AppColor.whiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  void showDateTime() async {
    var ChoosenTime = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    provider.selectedDate = ChoosenTime ?? provider.selectedDate;
    setState(() {});
  }

  void AddTask() {
    if (formkey.currentState!.validate()) {
      Task task = Task(
        title: title.text,
        desc: desc.text,
        dateTime: provider.selectedDate,
      );
      FirebaseUtils.addTasktoFireStore(task).timeout(
        const Duration(seconds: 1),
        onTimeout: () {
          print("Task added Successfully");
          provider.getAllTasksFromFireStore();

          Navigator.pop(context);
        },
      );
    }
  }
}
