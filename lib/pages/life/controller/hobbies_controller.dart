import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:to_do/share/theme.dart';

class HobbiesController extends GetxController {
  Rx<DateTime> today = DateTime.now().obs;
  Rx<Box<bool>> sportsBox = Hive.box<bool>('sports').obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(
      const Duration(minutes: 1),
      (_) { today.value = DateTime.now(); }
    );
    viewYear.value = DateTime(viewYear.value.year);
    firstDayIndex.value = DateTime(viewYear.value.year, 1, 1).weekday % 7;
    viewYearString.value = '${viewYear.value.year}';
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
  }

  // 管理当前显示的年份
  Rx<DateTime> viewYear = DateTime.now().obs;
  RxInt firstDayIndex = 0.obs;
  RxString viewYearString = ''.obs;
  void updateViewYear(int offset) {
    viewYear.value = DateTime(viewYear.value.year + offset);
    firstDayIndex.value = DateTime(viewYear.value.year, 1, 1).weekday % 7;
    viewYearString.value = '${viewYear.value.year}';
  }

  // 计算单元格对应的日期
  DateTime getCellDate(int index) {
    final int row = index ~/ 54;
    final int col = index % 54;
    final int offset = 7*col + row - firstDayIndex.value;
    return viewYear.value.add(Duration(days: offset));
  }

  // 判断符合条件的日期
  bool isToday(DateTime date) {
    return date.year == today.value.year &&
      date.month == today.value.month &&
      date.day == today.value.day;
  }
  bool isCurrentYear(DateTime date) {
    return date.year == viewYear.value.year;
  }
  bool isMonthOdd(DateTime date) {
    return date.month % 2 == 1;
  }

  // 查找日期对应的数据
  bool getSportsState(DateTime date) {
    String key = formatDate(date, [yyyy, mm, dd]);
    return sportsBox.value.get(key) != null;
  }

  // 判断单元格状态
  Color getSportsColor(DateTime date) {
    return getSportsState(date) ? AppColors.primary : Colors.transparent;
  }

  // 更新单元格状态
  void toggleSportsState(DateTime date) {
    String key = formatDate(date, [yyyy, mm, dd]);
    if (getSportsState(date)) {
      sportsBox.value.delete(key);
    } else {
      sportsBox.value.put(key, true);
    }
    sportsBox.refresh();
  }
}