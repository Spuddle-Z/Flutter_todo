import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';

import 'package:to_do/app/shared/widgets/item_tile.dart';

import 'package:to_do/core/theme.dart';

class RandomTaskController extends GetxController {
  final MainController mainController = Get.find<MainController>();

  // 状态变量
  final RxnInt randomKey = RxnInt(); // 随机任务的键

  // 计算变量
  List<dynamic> get keys =>
      mainController.triviaBox.value.keys.toList(); // 无截止日期任务列表
  bool get existTrivia => keys.isNotEmpty; // 是否存在无截止日期任务

  /// 获取随机任务的键
  void refreshRandomKey() {
    randomKey.value = existTrivia ? keys[Random().nextInt(keys.length)] : null;
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
        Get.find<RandomTaskController>();

    return Obx(() {
      if (randomTaskController.existTrivia) {
        // 存在无截止日期任务
        return Row(
          children: [
            Expanded(
              child: randomTaskController.randomKey.value == null
                  ? const Center(
                      child: Text(
                        'Roll a random task =>',
                        style: TextStyle(
                          color: MyColors.textDark,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ItemTile(
                      itemKey: randomTaskController.randomKey.value!,
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
                    color: MyColors.text,
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
              color: MyColors.textDark,
              fontSize: 16,
            ),
          ),
        );
      }
    });
  }
}
