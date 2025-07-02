import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/shared/widgets/item_tile.dart';
import 'package:to_do/app/pages/todo/todo_controller.dart';
import 'package:to_do/core/theme.dart';

class CalendarDayCellController extends GetxController {
  final int index;

  CalendarDayCellController({
    required this.index,
  });

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
    keys.sort((a, b) => mainController.sortItem(a, b));
    return keys;
  } // 获取本单元格内的任务键列表

  /// 过滤函数，判断任务是否要显示在当前单元格内
  bool ifShow(key) {
    bool done = mainController.taskBox.value.get(key)!.done;
    DateTime? date = mainController.taskBox.value.get(key)!.date;
    if (date == null) return false; // 如果没有截止日期，则不显示
    if (isToday) {
      return ((!done && date.isBefore(cellDate)) ||
          date.isAtSameMomentAs(cellDate));
    } else {
      return date.isAtSameMomentAs(cellDate);
    }
  }
}

class CalendarDayCell extends StatelessWidget {
  final int index;

  /// ### 日历单元格
  ///
  /// 该组件用于显示日历中的单个日期单元格，包含日期和该日期下的任务列表。
  const CalendarDayCell({
    super.key,
    required this.index,
  });

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
              ? MyColors.background
              : MyColors.backgroundDark,
          border: Border.all(
            color: dayCellController.isToday
                ? MyColors.textDark
                : MyColors.backgroundDark,
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
                    ? MyColors.textActive
                    : dayCellController.isWeekend
                        ? MyColors.textDark
                        : MyColors.text,
                fontWeight: dayCellController.isToday
                    ? FontWeight.bold
                    : FontWeight.normal,
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
                    return ItemTile(
                      itemKey: dayCellController.keys[index],
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
