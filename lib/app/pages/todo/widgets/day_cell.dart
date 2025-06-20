import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/app/pages/todo/widgets/task_tile.dart';
import 'package:to_do/app/pages/todo/todo_controller.dart';

import 'package:to_do/core/theme.dart';

// 日历单元格控制器
class DayCellController extends GetxController {
  DayCellController({
    required this.index,
  });
  final int index;

  final TodoController todoController = Get.find<TodoController>();

  // 计算变量
  Rx<DateTime> get cellDate =>
      Rx<DateTime>(todoController.getCellDate(index)); // 本单元格对应日期
  RxBool get isToday => RxBool(cellDate.value.day ==
          todoController.today.value.day &&
      cellDate.value.month == todoController.today.value.month &&
      cellDate.value.year == todoController.today.value.year); // 本单元格日期是否为今天
  RxBool get isCurrentMonth => RxBool(cellDate.value.month ==
      todoController.viewMonth.value.month); // 本单元格日期是否处于当前月份内
  RxBool get isWeekend => RxBool(cellDate.value.weekday == 7 ||
      cellDate.value.weekday == 6); // 本单元格日期是否为周末
  RxList<dynamic> get keys {
    RxList<dynamic> keys =
        todoController.taskBox.value.keys.where(ifShow).toList().obs;
    keys.sort((a, b) => todoController.sortTask(a, b));
    return keys;
  } // 获取本单元格内的任务键列表

  /// 过滤函数，判断任务是否要显示在当前单元格内
  bool ifShow(key) {
    bool taskDone = todoController.taskBox.value.get(key)!.taskDone;
    DateTime? taskDate = todoController.taskBox.value.get(key)!.taskDate;
    if (isToday.value) {
      return taskDate != null &&
          ((!taskDone && taskDate.isBefore(cellDate.value)) ||
              taskDate.isAtSameMomentAs(cellDate.value));
    } else {
      return taskDate != null && taskDate.isAtSameMomentAs(cellDate.value);
    }
  }
}

class DayCell extends StatelessWidget {
  /// ### 日历单元格
  ///
  /// 该组件用于显示日历中的单个日期单元格，包含日期和该日期下的任务列表。
  const DayCell({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final DayCellController dayCellController = Get.put(
        DayCellController(index: index),
        tag: 'dayCellController_$index');

    return Obx(() {
      return Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: dayCellController.isCurrentMonth.value
              ? AppColors.background
              : AppColors.backgroundDark,
          border: Border.all(
            color: dayCellController.isToday.value
                ? AppColors.textDark
                : AppColors.backgroundDark,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              '${dayCellController.cellDate.value.day}',
              style: TextStyle(
                color: dayCellController.isToday.value
                    ? AppColors.textActive
                    : dayCellController.isWeekend.value
                        ? AppColors.textDark
                        : AppColors.text,
              ),
            ),
            // 任务列表
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    const MaterialScrollBehavior().copyWith(scrollbars: false),
                child: ListView.builder(
                  itemCount: dayCellController.keys.length,
                  itemBuilder: (context, index) {
                    return TaskTile(
                      taskKey: dayCellController.keys[index],
                      isMiniTile: true,
                    );
                  },
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
