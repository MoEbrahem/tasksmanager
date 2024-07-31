import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasksmanager/AppColor.dart';
import 'package:tasksmanager/firebase_utils.dart';
import 'package:tasksmanager/model/TaskModel.dart';
import 'package:tasksmanager/provider.dart';

class EditTaskItem extends StatefulWidget {
  Task task;
  EditTaskItem({super.key, required this.task});

  @override
  State<EditTaskItem> createState() => _EditTaskItemState();
}

class _EditTaskItemState extends State<EditTaskItem> {
  late MyProvider provider;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyProvider>(context);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Task",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        child: SingleChildScrollView(
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
                  initialValue: widget.task.title,
                  onChanged: (value) {
                    widget.task.title = value;
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Task Title";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                TextFormField(
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyMedium,
                  initialValue: widget.task.desc,
                  onChanged: (value) {
                    
                    widget.task.desc = value;
                  },
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Type a Describtion";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
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
                    '${widget.task.dateTime.day}/${widget.task.dateTime.month}/${widget.task.dateTime.year}',
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
                    onEdit();
                  },
                  icon: const Icon(
                    Icons.done,
                    color: AppColor.whiteColor,
                  ),
                )
              ],
            ),
          ),
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
    widget.task.dateTime = ChoosenTime ?? widget.task.dateTime;
    setState(() {});
  }

  onEdit() {
    if (formkey.currentState!.validate()) {
      Task task = Task(
        id: widget.task.id,
        title: widget.task.title,
        desc: widget.task.desc,
        dateTime: widget.task.dateTime,
        isDone: widget.task.isDone,
      );

      provider.onpressEdit(task);
      Navigator.pop(context);
    }
  }
}
