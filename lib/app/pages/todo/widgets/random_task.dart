import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';

import 'package:to_do/app/shared/widgets/item_tile.dart';
import 'package:to_do/app/data/models/item_model.dart';
import 'package:to_do/app/shared/widgets/my_icon_button.dart';
import 'package:to_do/core/theme.dart';

class RandomItemController extends GetxController {
  final MainController mainController = Get.find<MainController>();

  // 状态变量
  final RxnInt randomKey = RxnInt(); // 随机任务的键

  // 计算变量
  List<dynamic> get keys => mainController.itemBox.value.keys.where(
        (key) {
          final Item item = mainController.itemBox.value.get(key)!;
          return !item.isTask;
        },
      ).toList(); // 杂事列表
  bool get existTrivia => keys.isNotEmpty; // 是否存在无截止日期任务

  /// 获取随机任务的键
  void refreshRandomKey() {
    randomKey.value = existTrivia ? keys[Random().nextInt(keys.length)] : null;
  }
}

class RandomTrivia extends StatelessWidget {
  /// ### 随机任务
  ///
  /// 该组件用于随机抽取一个没有截止日期的任务进行展示。
  const RandomTrivia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RandomItemController randomItemController =
        Get.find<RandomItemController>();

    return Obx(() {
      if (randomItemController.existTrivia) {
        // 存在无截止日期任务
        return Row(
          children: [
            Expanded(
              child: randomItemController.randomKey.value == null
                  ? const Center(
                      child: Text(
                        'Roll a random trivia =>',
                        style: TextStyle(
                          color: MyColors.textDark,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ItemTile(
                      itemKey: randomItemController.randomKey.value!,
                      isMiniTile: false,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: MyIconButton(
                icon: const Icon(Icons.refresh),
                color: MyColors.text,
                onPressed: randomItemController.refreshRandomKey,
              ),
            ),
          ],
        );
      } else {
        // 不存在无截止日期任务
        return const Center(
          child: Text(
            'No trivia <(￣︶￣)>',
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
