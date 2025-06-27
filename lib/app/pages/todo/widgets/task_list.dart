import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/app/pages/main/main_controller.dart';

import 'package:to_do/app/pages/todo/widgets/task_tile.dart';

class TaskListController extends GetxController {
  TaskListController({
    required this.filterTask,
  });
  final bool Function(dynamic) filterTask;

  final MainController mainController = Get.find<MainController>();

  // 计算变量
  RxList<dynamic> get keys {
    RxList<dynamic> keys =
        mainController.taskBox.value.keys.where(filterTask).toList().obs;
    keys.sort((a, b) => mainController.sortTask(a, b));
    return keys;
  } // 获取符合过滤条件的任务键列表
}

class TaskList extends StatelessWidget {
  /// ### 任务列表
  ///
  /// 该组件用于显示任务列表。
  const TaskList({
    super.key,
    required this.tag,
    required this.filterTask,
  });

  final String tag;
  final bool Function(dynamic) filterTask;

  @override
  Widget build(BuildContext context) {
    final TaskListController taskListController =
        Get.put(TaskListController(filterTask: filterTask), tag: tag);

    return Obx(() {
      return ListView.builder(
        itemCount: taskListController.keys.length,
        itemBuilder: (context, index) {
          return TaskTile(
            taskKey: taskListController.keys[index],
            isMiniTile: false,
          );
        },
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
      );
    });
  }
}
