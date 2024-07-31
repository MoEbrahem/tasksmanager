import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasksmanager/firebase_utils.dart';
import 'package:tasksmanager/model/TaskModel.dart';

class MyProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();
  ThemeMode appThemeMode = ThemeMode.light;

  void getAllTasksFromFireStore() async {
    QuerySnapshot<Task> querySnapShot =
        await FirebaseUtils.getTasksCollection().get();
    tasksList = querySnapShot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();

    tasksList = tasksList.where((task) {
      if (selectedDate.day == task.dateTime.day &&
          selectedDate.month == task.dateTime.month &&
          selectedDate.year == task.dateTime.year) {
        return true;
      } else {
        return false;
      }
    }).toList();
    tasksList.sort((Task t1, Task t2) => t1.dateTime.compareTo(t2.dateTime));
    notifyListeners();
  }

  void changeSelectDate(DateTime newDate) {
    selectedDate = newDate;
    getAllTasksFromFireStore();
  }

  void changeThemeMode(ThemeMode newTheme) {
    appThemeMode = newTheme;
    notifyListeners();
  }

  void onPressDone(Task t) {
    FirebaseUtils.getTasksCollection().doc(t.id).update(
      {"isDone": true}
      ).timeout(
        const Duration(microseconds:500),
        onTimeout: () {
          print("Task updated Successfully");
          getAllTasksFromFireStore();
        },
      );
    t.isDone = true;
    notifyListeners();
  }
  
  onpressEdit(Task task){
    FirebaseUtils.editTaskFromFireStore(task).timeout(
        const Duration(milliseconds: 500),
        onTimeout: () {
          print("Task Edited Successfully");
          getAllTasksFromFireStore();
        },
      );
  }
}
