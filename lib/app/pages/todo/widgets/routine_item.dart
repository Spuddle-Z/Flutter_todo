import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/core/utils.dart';
import 'package:to_do/app/shared/widgets/my_checkbox.dart';
import 'package:to_do/app/data/models/routine_model.dart';
import 'package:to_do/core/theme.dart';

class RoutineItemController extends GetxController {
  RoutineItemController({
    required this.routineKey,
  });

  final int routineKey;

  final MainController mainController = Get.find<MainController>();

  /// 计算变量
  Routine get routine =>
      mainController.routineBox.value.get(routineKey)!; // 获取日程数据
  String get routineContent => routine.content;

  bool get routineState => isSameDay(routine.date, mainController.today.value);

  /// 更新日程状态
  void onRoutineToggled() {
    final updatedRoutine = Routine.copy(routine);
    updatedRoutine.date = routineState ? null : mainController.today.value;
    mainController.updateRoutine(routineKey, updatedRoutine);
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
            onChanged: (_) => routineItemController.onRoutineToggled(),
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
