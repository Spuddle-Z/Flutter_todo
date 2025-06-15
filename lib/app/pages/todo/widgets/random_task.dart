import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:to_do/app/pages/todo/controller/task_controller.dart';

import '../../../shared/widgets/task_tile.dart';
import 'package:to_do/core/theme.dart';


// 随机任务抽取
class RandomTask extends StatelessWidget {
  const RandomTask({
    super.key,
    required this.taskController,
  });

  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final RxList<dynamic> keys = taskController.taskBox.value.keys.where((k) => taskController.taskBox.value.get(k)!.taskDate == null).toList().obs;
      final RxnInt key = RxnInt();
      RxInt expandedKey = (-1).obs;

      void refreshKey() {
        key.value = keys.isNotEmpty ? keys[Random().nextInt(keys.length)] : null;
      }

      refreshKey();
      if (key.value == null) {
        return const Center(
          child: Text(
            'No task without deadline <(￣︶￣)>',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 16,
            ),
          ),
        );
      } else {
        return Row(
          children: [
            Expanded(
              child: TaskTile(
                task: taskController.taskBox.value.get(key.value)!,
                taskKey: key.value!,
                funcToggle: taskController.toggleTask,
                funcDelete: taskController.deleteTask,
                tileColor: taskController.getTaskColor(key.value!, true),
                expandedKey: expandedKey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: TextButton(
                style: textButtonStyle(),
                onPressed: refreshKey,
                child: const Padding(
                  padding: EdgeInsets.all(9.5),
                  child: Icon(
                    Icons.refresh,
                    color: AppColors.text,
                  ),
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
