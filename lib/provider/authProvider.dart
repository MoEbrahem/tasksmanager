import 'package:flutter/material.dart';
import 'package:tasksmanager/model/userModel.dart';

class Authprovider extends ChangeNotifier {
  UserModel? userModel;

  void updateUser(UserModel newUserModel) {
    userModel = newUserModel;
    notifyListeners();
  }
}
