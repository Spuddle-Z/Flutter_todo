import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/task_controller.dart';

import 'task_tile.dart';


// 任务列表
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
      keys.sort((a, b) => taskController.sortTask(a, b));
      RxInt expandedKey = (-1).obs;

      return ListView.builder(
        itemCount: keys.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: taskController.taskBox.value.get(keys[index])!,
            taskKey: keys[index],
            funcToggle: taskController.toggleTask,
            funcDelete: taskController.deleteTask,
            tileColor: taskController.getTaskColor(keys[index], true),
            expandedKey: expandedKey,
          );
        },
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
      );
    });
  }
}
