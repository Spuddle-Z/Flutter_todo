import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/task_controller.dart';

class ButtonsArea extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.find<TaskController>();
    return TextButton(
      onPressed: () => taskController.addTask('New Task', false, 0),
      child: const Text('Add Task'),
    );
  }
}