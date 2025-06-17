import 'dart:async';
import 'package:get/get.dart';

class TodoController extends GetxController {
  Rx<DateTime> today = DateTime.now().obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(const Duration(minutes: 1), (_) {
      today.value = DateTime.now();
    });
    firstDayIndex.value =
        DateTime(viewMonth.value.year, viewMonth.value.month, 1).weekday % 7;
    viewMonthString.value =
        '${viewMonth.value.year} - ${months[viewMonth.value.month - 1]}';
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
  }

  // 管理当前显示的月份
  final List<String> months = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  Rx<DateTime> viewMonth = DateTime.now().obs;
  RxInt firstDayIndex = 0.obs;
  RxString viewMonthString = ''.obs;
  void updateViewMonth(int offset) {
    viewMonth.value =
        DateTime(viewMonth.value.year, viewMonth.value.month + offset);
    firstDayIndex.value =
        DateTime(viewMonth.value.year, viewMonth.value.month, 1).weekday % 7;
    viewMonthString.value =
        '${viewMonth.value.year} - ${months[viewMonth.value.month - 1]}';
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
