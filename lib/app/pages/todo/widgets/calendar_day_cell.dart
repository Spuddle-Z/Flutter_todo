import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/data/models/item_model.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/shared/widgets/item_tile.dart';
import 'package:to_do/app/pages/todo/todo_controller.dart';
import 'package:to_do/core/theme.dart';
import 'package:to_do/core/utils.dart';

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
      isSameDay(cellDate, mainController.today.value); // 本单元格日期是否为今天
  bool get isCurrentMonth =>
      cellDate.month == todoController.viewMonth.value.month; // 本单元格日期是否处于当前月份内
  bool get isWeekend =>
      cellDate.weekday == 7 || cellDate.weekday == 6; // 本单元格日期是否为周末

  // 缓存的键列表
  final RxList<dynamic> _cachedKeys = <dynamic>[].obs;

  // 获取本单元格内的任务键列表（已缓存）
  List<dynamic> get keys => _cachedKeys;

  // 更新键列表的防抖定时器
  Timer? _updateTimer;

  @override
  void onInit() {
    super.onInit();
    _updateKeys();
    // 监听 itemBox 和 today 变化，使用防抖批量更新缓存
    ever(mainController.itemBox, (_) => _scheduleUpdate());
    ever(mainController.today, (_) => _scheduleUpdate());
    ever(todoController.viewMonth, (_) => _updateKeys()); // 月份变化立即更新
  }

  @override
  void onClose() {
    _updateTimer?.cancel();
    super.onClose();
  }

  /// 防抖，避免频繁更新
  void _scheduleUpdate() {
    _updateTimer?.cancel();
    _updateTimer = Timer(const Duration(milliseconds: 100), () {
      _updateKeys();
    });
  }

  /// 更新键列表缓存
  void _updateKeys() {
    List<dynamic> newKeys =
        mainController.itemBox.value.keys.where(ifShow).toList();
    newKeys.sort((a, b) => mainController.sortItem(a, b));
    _cachedKeys.value = newKeys;
  }

  /// 过滤函数，判断任务是否要显示在当前单元格内
  bool ifShow(key) {
    Item item = mainController.itemBox.value.get(key)!;
    if (!item.isTask) return false; // 只显示任务类型的条目
    if (isToday) {
      return ((!item.done && item.date!.isBefore(cellDate)) ||
          isSameDay(item.date, cellDate));
    }
    return isSameDay(item.date, cellDate);
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
              child: Obx(() {
                return ScrollConfiguration(
                  behavior: const MaterialScrollBehavior()
                      .copyWith(scrollbars: false),
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
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
