import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/task_controller.dart';

import '../widget/recessed_panel.dart';
import '../widget/task_list.dart';


class TaskLists extends StatelessWidget {
  TaskLists({super.key});

  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    bool todayFilter(k) {
      DateTime? date = taskController.taskBox.value.get(k)!.taskDate;
      return date != null && date.isBefore(DateTime.now());
    }
    // bool noDeadlineFilter(k) {
    //   return true;
    // }
    bool noDeadlineFilter(k) {
      DateTime? date = taskController.taskBox.value.get(k)!.taskDate;
      return date == null;
    }

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: RecessedPanel(
            child: TaskList(
              taskController: taskController,
              funcFilter: todayFilter,
            )
          )
        ),
        Expanded(
          flex: 3,
          child: RecessedPanel(
            child: TaskList(
              taskController: taskController,
              funcFilter: noDeadlineFilter,
            )
          )
        ),
      ],
    );
  }
}
