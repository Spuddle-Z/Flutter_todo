import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/task_controller.dart';
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
          blurRadius: 2,
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
    return Obx(() => ListView.builder(
      itemCount: taskController.tasks.length,
      itemBuilder: (context, index) {
        return TaskTile(
          taskIndex: index,
          taskContent: taskController.tasks[index].taskContent,
          taskDone: taskController.tasks[index].taskDone,
          taskPriority: taskController.tasks[index].taskPriority,
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
    return Obx(() => ListView.builder(
      itemCount: taskController.tasks.length,
      itemBuilder: (context, index) {
        return TaskTile(
          taskIndex: index,
          taskContent: taskController.tasks[index].taskContent,
          taskDone: taskController.tasks[index].taskDone,
          taskPriority: taskController.tasks[index].taskPriority,
          onChanged: (value) => taskController.toggleTask(index),
          onDelete: () => taskController.deleteTask(index),
        );
      },
    ));
  }
}
