import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/shared/widgets/recessed_panel.dart';
import 'package:to_do/app/pages/todo/widgets/task_list.dart';
import 'package:to_do/app/pages/todo/widgets/random_task.dart';
import 'package:to_do/core/theme.dart';

class MyDay extends StatelessWidget {
  MyDay({super.key});

  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    bool filterTodayTask(key) {
      DateTime? date = mainController.taskBox.value.get(key)!.taskDate;
      bool done = mainController.taskBox.value.get(key)!.taskDone;
      DateTime today = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      return date != null &&
          ((!done && date.isBefore(today)) || date.isAtSameMomentAs(today));
    }

    bool filterNoDeadlineTask(key) {
      DateTime? date = mainController.taskBox.value.get(key)!.taskDate;
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
                    tag: 'today',
                    filterTask: filterTodayTask,
                  ),
                ),
              ],
            ))),
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
                const RandomTask(),
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
                    tag: 'noDeadline',
                    filterTask: filterNoDeadlineTask,
                  ),
                ),
              ],
            ))),
      ],
    );
  }
}
