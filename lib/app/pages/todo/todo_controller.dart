import 'package:get/get.dart';

import 'package:to_do/app/pages/main/main_controller.dart';

import 'package:to_do/app/shared/constants/calendar_constant.dart';

class TodoController extends GetxController {
  final MainController mainController = Get.find<MainController>();

  // 状态变量
  final Rx<DateTime> viewMonth = DateTime.now().obs; // 当前显示的月份

  // 计算变量
  RxInt get firstDayIndex =>
      RxInt(DateTime(viewMonth.value.year, viewMonth.value.month, 1).weekday %
          7); // 当前显示月份的第一天在一周中的索引
  RxString get viewMonthText => RxString(
      '${viewMonth.value.year} - ${CalendarConstant.monthTextList[viewMonth.value.month - 1]}'); // 当前显示月份的文本表示

  /// 切换显示的月份
  void onViewMonthChanged(int offset) {
    viewMonth.value =
        DateTime(viewMonth.value.year, viewMonth.value.month + offset);
    firstDayIndex.value =
        DateTime(viewMonth.value.year, viewMonth.value.month, 1).weekday % 7;
    viewMonthText.value =
        '${viewMonth.value.year} - ${CalendarConstant.monthTextList[viewMonth.value.month - 1]}';
  }

  /// 计算单元格对应的日期。
  ///
  /// 输入参数：
  /// - `index` 单元格的索引，从0开始。
  ///
  /// 返回值：
  /// - 对应的日期。
  DateTime getCellDate(int index) {
    if (index < firstDayIndex.value) {
      final DateTime lastMonth =
          DateTime(viewMonth.value.year, viewMonth.value.month, 0);
      return DateTime(lastMonth.year, lastMonth.month,
          lastMonth.day - firstDayIndex.value + index + 1);
    } else if (index <
        firstDayIndex.value +
            DateTime(viewMonth.value.year, viewMonth.value.month + 1, 0).day) {
      return DateTime(viewMonth.value.year, viewMonth.value.month,
          index - firstDayIndex.value + 1);
    } else {
      return DateTime(
          viewMonth.value.year,
          viewMonth.value.month + 1,
          index -
              firstDayIndex.value -
              DateTime(viewMonth.value.year, viewMonth.value.month + 1, 0).day +
              1);
    }
  }
}
