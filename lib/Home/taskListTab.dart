// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:provider/provider.dart';
import 'package:tasksmanager/provider.dart';
import 'package:tasksmanager/widgets/itemlistsTasks.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    if (provider.tasksList.isEmpty) {
      provider.getAllTasksFromFireStore();
    }
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: EasyDateTimeLine(
            initialDate: provider.selectedDate,
            onDateChange: (selectedDate) {
              provider.changeSelectDate(selectedDate);
            },
            headerProps:  EasyHeaderProps(
              selectedDateStyle: Theme.of(context).textTheme.headlineSmall,
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: const DateFormatter.fullDateDMonthAsStrY(),
            ),
            dayProps:  EasyDayProps(
              
              dayStructure: DayStructure.dayStrDayNum,
              inactiveDayNumStyle: Theme.of(context).textTheme.headlineSmall,

              activeDayStyle: const DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff3371FF),
                      Color(0xff8426D6),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            // scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: provider.tasksList.length,
            itemBuilder: (context, index) {
              return ItemListTasks(task: provider.tasksList[index]);
            },
          ),
        )
      ],
    );
  }
}
