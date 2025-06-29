import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/pages/todo/widgets/task_tile.dart';
import 'package:to_do/app/pages/todo/todo_controller.dart';
import 'package:to_do/core/theme.dart';

// 日历单元格控制器
class CalendarDayCellController extends GetxController {
  CalendarDayCellController({
    required this.index,
  });
  final int index;

  final MainController mainController = Get.find<MainController>();
  final TodoController todoController = Get.find<TodoController>();

  // 计算变量
  DateTime get cellDate => todoController.getCellDate(index); // 本单元格对应日期
  bool get isToday =>
      cellDate.day == mainController.today.value.day &&
      cellDate.month == mainController.today.value.month &&
      cellDate.year == mainController.today.value.year; // 本单元格日期是否为今天
  bool get isCurrentMonth =>
      cellDate.month == todoController.viewMonth.value.month; // 本单元格日期是否处于当前月份内
  bool get isWeekend =>
      cellDate.weekday == 7 || cellDate.weekday == 6; // 本单元格日期是否为周末
  List<dynamic> get keys {
    List<dynamic> keys =
        mainController.taskBox.value.keys.where(ifShow).toList();
    keys.sort((a, b) => mainController.sortTask(a, b));
    return keys;
  } // 获取本单元格内的任务键列表

  /// 过滤函数，判断任务是否要显示在当前单元格内
  bool ifShow(key) {
    bool taskDone = mainController.taskBox.value.get(key)!.taskDone;
    DateTime? taskDate = mainController.taskBox.value.get(key)!.taskDate;
    if (isToday) {
      return taskDate != null &&
          ((!taskDone && taskDate.isBefore(cellDate)) ||
              taskDate.isAtSameMomentAs(cellDate));
    } else {
      return taskDate != null && taskDate.isAtSameMomentAs(cellDate);
    }
  }
}

class CalendarDayCell extends StatelessWidget {
  /// ### 日历单元格
  ///
  /// 该组件用于显示日历中的单个日期单元格，包含日期和该日期下的任务列表。
  const CalendarDayCell({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final CalendarDayCellController dayCellController = Get.put(
        CalendarDayCellController(index: index),
        tag: 'dayCellController_$index');

    return Obx(() {
      return Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: dayCellController.isCurrentMonth
              ? AppColors.background
              : AppColors.backgroundDark,
          border: Border.all(
            color: dayCellController.isToday
                ? AppColors.textDark
                : AppColors.backgroundDark,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              '${dayCellController.cellDate.day}',
              style: TextStyle(
                color: dayCellController.isToday
                    ? AppColors.textActive
                    : dayCellController.isWeekend
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
                      cellDate: dayCellController.cellDate,
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
