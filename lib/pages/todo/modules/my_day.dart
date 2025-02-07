import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/pages/todo/controller/task_controller.dart';

import 'package:to_do/share/widgets/recessed_panel.dart';
import 'package:to_do/pages/todo/widgets/task_list.dart';
import 'package:to_do/pages/todo/widgets/random_task.dart';
import 'package:to_do/share/theme.dart';


class TaskLists extends StatelessWidget {
  TaskLists({super.key});

  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    bool todayFilter(k) {
      DateTime? date = taskController.taskBox.value.get(k)!.taskDate;
      bool done = taskController.taskBox.value.get(k)!.taskDone;
      DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      return date != null && ((!done && date.isBefore(today)) || date.isAtSameMomentAs(today));
    }
    bool noDeadlineFilter(k) {
      DateTime? date = taskController.taskBox.value.get(k)!.taskDate;
      return date == null;
    }

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: RecessedPanel(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Today',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: TaskList(
                    taskController: taskController,
                    funcFilter: todayFilter,
                  ),
                ),
              ],
            )
          )
        ),
        Expanded(
          flex: 3,
          child: RecessedPanel(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'No Deadline',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RandomTask(taskController: taskController),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.textDark,
                  ),
                ),
                Expanded(
                  child: TaskList(
                    taskController: taskController,
                    funcFilter: noDeadlineFilter,
                  ),
                ),
              ],
            )
          )
        ),
      ],
    );
  }
}
