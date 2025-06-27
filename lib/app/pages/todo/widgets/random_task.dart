import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';

import 'package:to_do/app/pages/todo/widgets/task_tile.dart';

import 'package:to_do/core/theme.dart';

class RandomTaskController extends GetxController {
  final MainController mainController = Get.find<MainController>();

  // 状态变量
  final RxnInt randomKey = RxnInt(); // 随机任务的键

  // 计算变量
  List<dynamic> get keys => mainController.taskBox.value.keys
      .where((k) => mainController.taskBox.value.get(k)!.taskDate == null)
      .toList(); // 无截止日期任务列表
  bool get existNoDeadlineTask => keys.isNotEmpty; // 是否存在无截止日期任务

  /// 获取随机任务的键
  void refreshRandomKey() {
    final keys = mainController.taskBox.value.keys
        .where((k) => mainController.taskBox.value.get(k)!.taskDate == null)
        .toList();

    // 如果没有符合条件的任务，随机键为 null
    randomKey.value =
        keys.isNotEmpty ? keys[Random().nextInt(keys.length)] : null;
  }
}

class RandomTask extends StatelessWidget {
  /// ### 随机任务
  ///
  /// 该组件用于随机抽取一个没有截止日期的任务进行展示。
  const RandomTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RandomTaskController randomTaskController =
        Get.put(RandomTaskController());
    return Obx(() {
      if (randomTaskController.existNoDeadlineTask) {
        // 存在无截止日期任务
        return Row(
          children: [
            Expanded(
              child: randomTaskController.randomKey.value == null
                  ? const Center(
                      child: Text(
                        'Roll a random task =>',
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : TaskTile(
                      taskKey: randomTaskController.randomKey.value!,
                      isMiniTile: false,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: TextButton(
                style: textButtonStyle(),
                onPressed: randomTaskController.refreshRandomKey,
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
      } else {
        // 不存在无截止日期任务
        return const Center(
          child: Text(
            'No task without deadline <(￣︶￣)>',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 16,
            ),
          ),
        );
      }
    });
  }
}
