import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/task_controller.dart';
import '../util/tile_controller.dart';
import 'recessed_panel.dart';
import 'task_tile.dart';


class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: RecessedPanel(
            child: const TasksToday()
          )
        ),
        Expanded(
          flex: 3,
          child: RecessedPanel(
            child: const TasksNoDeadline()
          )
        ),
      ],
    );
  }
}

class TasksToday extends StatelessWidget {
  const TasksToday({super.key});

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.find<TaskController>();
    TileController tileController = Get.find<TileController>();

    return Obx(() => 
      ListView.builder(
        itemCount: taskController.testKeys.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: taskController.taskBox.get(taskController.testKeys[index])!,
            taskKey: taskController.testKeys[index],
            showKey: tileController.showTodayKey,
            funcToggle: taskController.toggleTask,
            funcToggleExpand: tileController.todayToggleExpand,
            funcDelete: taskController.deleteTask,
          );
        },
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
      )
    );
  }
}

class TasksNoDeadline extends StatelessWidget {
  const TasksNoDeadline({super.key});

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.find<TaskController>();
    TileController tileController = Get.find<TileController>();

    return Obx(() => 
      ListView.builder(
        itemCount: taskController.keyList.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: taskController.taskBox.get(taskController.keyList[index])!,
            taskKey: taskController.keyList[index],
            showKey: tileController.showNoDeadlineKey,
            funcToggle: taskController.toggleTask,
            funcToggleExpand: tileController.noDeadlineToggleExpand,
            funcDelete: taskController.deleteTask,
          );
        },
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
      )
    );
  }
}
