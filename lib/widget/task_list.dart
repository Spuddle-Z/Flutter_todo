import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/task_controller.dart';
import '../util/tile_controller.dart';
import 'task_tile.dart';
import '../theme.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RecessedPanel(
            child: const TasksToday()
          )
        ),
        Expanded(
          child: RecessedPanel(
            child: const TasksNoDeadline()
          )
        ),
      ],
    );
  }
}

class RecessedPanel extends Container {
  RecessedPanel({super.key, required Widget child}): super(
    child: child,
    decoration: BoxDecoration(
      color: AppColors.backgroundDark,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(0x80),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(8),
  );
}

class TasksToday extends StatelessWidget {
  const TasksToday({super.key});

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.find<TaskController>();
    TileController tileController = Get.find<TileController>();

    return Obx(() => ListView.builder(
      itemCount: taskController.testTasks.length,
      itemBuilder: (context, index) {
        return TaskTile(
          task: taskController.testTasks[index],
          showId: tileController.showTodayId,
          onChanged: (value) => taskController.toggleTask(index),
          onDelete: () => taskController.deleteTask(index),
        );
      },
    ));
  }
}

class TasksNoDeadline extends StatelessWidget {
  const TasksNoDeadline({super.key});

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.find<TaskController>();
    TileController tileController = Get.find<TileController>();

    return Obx(() => ListView.builder(
      itemCount: taskController.tasks.length,
      itemBuilder: (context, index) {
        return TaskTile(
          task: taskController.tasks[index],
          showId: tileController.showNoDeadlineId,
          onChanged: (value) => taskController.toggleTask(index),
          onDelete: () => taskController.deleteTask(index),
        );
      },
    ));
  }
}
