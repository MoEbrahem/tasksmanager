import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasksmanager/constants/dialog_utils.dart';
import 'package:tasksmanager/firebase_utils.dart';
import 'package:tasksmanager/model/TaskModel.dart';

class MyProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();
  ThemeMode appThemeMode = ThemeMode.light;
  String collectionName = "users";

  void getAllTasksFromFireStore(String uid) async {
    QuerySnapshot<Task> querySnapShot =
        await FirebaseUtils.getTasksCollection(uid).get();
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

  void changeSelectDate(DateTime newDate,String uid) {
    selectedDate = newDate;
    getAllTasksFromFireStore(uid);
  }

  void changeThemeMode(ThemeMode newTheme) {
    appThemeMode = newTheme;
    notifyListeners();
  }

  void onPressDone(Task t,String uid) {
    FirebaseUtils.getTasksCollection(uid)
        .doc(t.id)
        .update({"isDone": true}).timeout(
      const Duration(microseconds: 500),
      onTimeout: () {
        print("Task updated Successfully");
        getAllTasksFromFireStore(uid);
      },
    );
    t.isDone = true;
    notifyListeners();
  }

  onpressEdit(Task task,String uid) {
    FirebaseUtils.editTaskFromFireStore(task,uid).then((value){
        print("Task Edited Successfully");
        getAllTasksFromFireStore(uid);
      }
    ).timeout(
                  const Duration(seconds: 3),
                  onTimeout: () {
                    DialogUtils.showtoastMessage("Task Deleted Successfully");
                  },
                );
  }
}
