import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/shared/widgets/my_checkbox.dart';
import 'package:to_do/core/theme.dart';

class RoutineItemController extends GetxController {
  RoutineItemController({
    required this.routineKey,
  });

  final int routineKey;

  final MainController mainController = Get.find<MainController>();

  /// 计算变量
  String get routineContent =>
      mainController.routineBox.value.get(routineKey)!.content;
  bool get routineState =>
      mainController.routineBox.value.get(routineKey)!.date ==
      mainController.today.value;

  /// 更新日程状态
  void toggleRoutineState() {
    if (routineState) {
      mainController.routineBox.value.get(routineKey)!.updateDate(null);
    } else {
      mainController.routineBox.value
          .get(routineKey)!
          .updateDate(mainController.today.value);
    }
    mainController.routineBox.refresh();
  }
}

class RoutineItem extends StatelessWidget {
  /// ### 日程项组件
  ///
  /// 该组件用于显示一个日程项，包括勾选框和文本。
  const RoutineItem({
    super.key,
    required this.routineKey,
  });
  final int routineKey;

  @override
  Widget build(BuildContext context) {
    final RoutineItemController routineItemController = Get.put(
      RoutineItemController(routineKey: routineKey),
      tag: 'routineItem_$routineKey',
    );

    return Row(
      children: [
        Obx(() {
          return MyCheckbox(
            done: routineItemController.routineState,
            color: MyColors.textDark,
            activeColor: MyColors.primary,
            scale: 1,
            onChanged: (_) => routineItemController.toggleRoutineState(),
          );
        }),
        Expanded(
          child: Text(
            routineItemController.routineContent,
            style: const TextStyle(
              color: MyColors.text,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
