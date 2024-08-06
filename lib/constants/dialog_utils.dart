import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasksmanager/constants/AppColor.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context, String msg) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              
              children: [
                const CircularProgressIndicator(
                  color: AppColor.primaryLightColor,
                ),
                Spacer(),
                Text(msg),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    String title = '',
    required String content,
    String? postActionNamed,
    Function()? posaction,
    String? negActionNamed,
    Function()? negaction,
  }) {
    List<Widget> actions = [];
    if (postActionNamed != null) {
      actions.add(
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            posaction?.call();
          },
          child: Text(
            postActionNamed,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColor.darkBackgroundColor),
          ),
        ),
      );
    }
    if (negActionNamed != null) {
      actions.add(
        ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColor.deleteColor),
          ),
          onPressed: () {
            Navigator.pop(context);
            negaction?.call();
          },
          child: Text(negActionNamed),
        ),
      );
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title,style: const TextStyle(color: AppColor.darkBackgroundColor),),
          content: Text(
            content,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColor.darkBackgroundColor),
          ),
          actions: actions,
        );
      },
    );
  }

  static void showtoastMessage(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
