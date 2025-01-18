import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/task_controller.dart';
import 'recessed_panel.dart';
import 'task_tile.dart';


class TaskLists extends StatelessWidget {
  TaskLists({super.key});

  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    bool todayFilter(k) {
      DateTime? date = taskController.taskBox.value.get(k)!.taskDate;
      return date != null && 
        date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day;
    }
    bool noDeadlineFilter(k) {
      return true;
    }
    // bool noDeadlineFilter(k) {
    //   DateTime? date = taskController.taskBox.value.get(k)!.taskDate;
    //   return date == null;
    // }

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

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.taskController,
    required this.funcFilter,
  });

  final TaskController taskController;
  final bool Function(dynamic) funcFilter;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final RxList<dynamic> keys = taskController.taskBox.value.keys.where(funcFilter).toList().obs;
      RxInt expandedKey = (-1).obs;

      return ListView.builder(
        itemCount: keys.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: taskController.taskBox.value.get(keys[index])!,
            taskKey: keys[index],
            funcToggle: taskController.toggleTask,
            funcDelete: taskController.deleteTask,
            expandedKey: expandedKey,
          );
        },
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
      );
    });
  }
}
