import 'package:get/get.dart';
import 'package:to_do/app/data/models/item_model.dart';

import 'package:to_do/app/pages/main/main_controller.dart';

import 'package:to_do/app/shared/constants/calendar_constant.dart';

class TodoController extends GetxController {
  final MainController mainController = Get.find<MainController>();

  // 状态变量
  final Rx<DateTime> viewMonth = DateTime.now().obs; // 当前显示的月份

  // 计算变量
  int get firstDayIndex =>
      DateTime(viewMonth.value.year, viewMonth.value.month, 1).weekday %
      7; // 当前显示月份的第一天在一周中的索引
  String get viewMonthText =>
      '${viewMonth.value.year} - ${CalendarConstant.monthTextList[viewMonth.value.month - 1]}'; // 当前显示月份的文本表示

  /// 计算单元格对应的日期。
  ///
  /// 输入参数：
  /// - `index` 单元格的索引，从0开始。
  ///
  /// 返回值：
  /// - 对应的日期。
  DateTime getCellDate(int index) {
    if (index < firstDayIndex) {
      final DateTime lastMonth =
          DateTime(viewMonth.value.year, viewMonth.value.month, 0);
      return DateTime(lastMonth.year, lastMonth.month,
          lastMonth.day - firstDayIndex + index + 1);
    } else if (index <
        firstDayIndex +
            DateTime(viewMonth.value.year, viewMonth.value.month + 1, 0).day) {
      return DateTime(viewMonth.value.year, viewMonth.value.month,
          index - firstDayIndex + 1);
    } else {
      return DateTime(
          viewMonth.value.year,
          viewMonth.value.month + 1,
          index -
              firstDayIndex -
              DateTime(viewMonth.value.year, viewMonth.value.month + 1, 0).day +
              1);
    }
  }

  /// 过滤今天的任务
  bool filterTodayTask(key) {
    Item item = mainController.itemBox.value.get(key)!;
    if (!item.isTask) return false; // 只处理任务类型
    DateTime date = item.date!;
    return ((!item.done && date.isBefore(mainController.today.value)) ||
        date.isAtSameMomentAs(mainController.today.value));
  }
}
