import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/app/pages/main/main_controller.dart';

import 'package:to_do/app/pages/todo/widgets/routine_item.dart';

class RoutineListController extends GetxController {
  final MainController mainController = Get.find<MainController>();

  // 获取缓存好的日程键列表
  List<dynamic> get keys => mainController.routineBox.value.keys.toList();
}

class RoutineList extends StatelessWidget {
  /// ### 日程列表
  ///
  /// 该组件用于显示日程列表。
  const RoutineList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RoutineListController routineListController =
        Get.put(RoutineListController());

    return Obx(() {
      return ListView.builder(
        itemCount: routineListController.keys.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.02,
              vertical: 4,
            ),
            child: RoutineItem(
              routineKey: routineListController.keys[index],
            ),
          );
        },
      );
    });
  }
}
