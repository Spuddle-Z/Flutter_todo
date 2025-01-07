import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/task_controller.dart';
import 'task_tile.dart';

// List testTaskList = [
//   {
//     'taskContent': 'Buy groceries',
//     'taskDone': false,
//     'taskPriority': 2,
//   },
//   {
//     'taskContent': 'Walk the dog',
//     'taskDone': false,
//     'taskPriority': 1,
//   },
//   {
//     'taskContent': 'Cook dinner',
//     'taskDone': false,
//     'taskPriority': 0,
//   },
// ];

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: TasksToday()),
      ],
    );
  }
}

class TasksToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.find<TaskController>();
    return ListView.builder(
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
    );
  }
}

class TasksNoDeadline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.find<TaskController>();
    return ListView.builder(
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
    );
  }
}
