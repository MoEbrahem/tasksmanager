import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tasksmanager/constants/AppColor.dart';
import 'package:tasksmanager/constants/dialog_utils.dart';
import 'package:tasksmanager/firebase_utils.dart';
import 'package:tasksmanager/model/TaskModel.dart';
import 'package:tasksmanager/provider/authProvider.dart';
import 'package:tasksmanager/provider/provider.dart';
import 'package:tasksmanager/widgets/editTask.dart';

class ItemListTasks extends StatelessWidget {
  Task task;
  ItemListTasks({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var authprovider = Provider.of<Authprovider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.60,
          dragDismissible: false,
          motion: const DrawerMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {},
          ),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              onPressed: (context) {
                FirebaseUtils.deleteTaskFromFireStore(
                        task, 
                        authprovider.userModel!.id)
                    .then(
                  (value) {
                    print("Task Deleted Successfully");
                    provider.getAllTasksFromFireStore(
                        authprovider.userModel!.id);
                  },
                )

                .timeout(
                  const Duration(seconds: 2),
                  onTimeout: () {
                    DialogUtils.showtoastMessage("Task Deleted Successfully");
                  },
                );
              },
              backgroundColor: AppColor.deleteColor,
              foregroundColor: AppColor.whiteColor,
              icon: Icons.delete,
              label: "Delete",
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              onPressed: (context) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditTaskItem(task: task),
                  ),
                );
              },
              backgroundColor: AppColor.doneColor,
              foregroundColor: AppColor.whiteColor,
              icon: Icons.edit,
              label: "Edit",
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          height: height * 0.129,
          decoration: BoxDecoration(
            border: Border.all(
              color: task.isDone == false
                  ? AppColor.primaryLightColor
                  : AppColor.doneColor,
            ),
            borderRadius: BorderRadius.circular(15),
            color: provider.appThemeMode == ThemeMode.light
                ? AppColor.whiteColor
                : AppColor.darkBackgroundColor,
          ),
          child: Row(
            children: [
              Container(
                height: double.infinity,
                width: width * 0.009,
                color: task.isDone == false
                    ? AppColor.primaryLightColor
                    : AppColor.doneColor,
                margin: const EdgeInsets.only(right: 20),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        task.title,
                        style: task.isDone == false
                            ? Theme.of(context).textTheme.titleMedium
                            : Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppColor.doneColor),
                      ),
                      Text(
                        task.desc,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
              task.isDone == false
                  ? MaterialButton(
                      color: AppColor.primaryLightColor,
                      minWidth: width * 0.09,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        provider.onPressDone(
                            task, authprovider.userModel?.id ?? '');
                      },
                      child: const Icon(
                        Icons.done,
                        color: AppColor.whiteColor,
                        size: 25,
                      ),
                    )
                  : Text(
                      "Done!",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColor.doneColor),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
