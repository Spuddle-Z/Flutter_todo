import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:to_do/core/theme.dart';


// 管理hobbies数据
class HobbiesController extends GetxController {
  Rx<DateTime> today = DateTime.now().obs;
  Rx<Box<bool>> sportsBox = Hive.box<bool>('Sports').obs;
  Rx<Box<bool>> relaxBox = Hive.box<bool>('Relax').obs;
  Rx<Box<bool>> riseBox = Hive.box<bool>('Rise').obs;
  Rx<Box<bool>> sleepBox = Hive.box<bool>('Sleep').obs;

  // 通过仓库名找到对应的数据
  Rx<Box<bool>> getBox(String box) {
    switch (box) {
      case 'Sports':
        return sportsBox;
      case 'Relax':
        return relaxBox;
      case 'Early Rise':
        return riseBox;
      case 'Early Sleep':
        return sleepBox;
      default:
        return sportsBox;
    }
  }

  // 查找日期对应的数据
  bool getState(String box, DateTime date) {
    String key = formatDate(date, [yyyy, mm, dd]);
    return getBox(box).value.get(key) != null;
  }

  // 判断单元格颜色
  Color getColor(String box, DateTime date) {
    switch (box) {
      case 'Sports':
        return getState(box, date) ? AppColors.green : Colors.transparent;
      case 'Relax':
        return getState(box, date) ? AppColors.purple : Colors.transparent;
      case 'Early Rise':
        return getState(box, date) ? AppColors.primary : Colors.transparent;
      case 'Early Sleep':
        return getState(box, date) ? AppColors.primary : Colors.transparent;
      default:
        return Colors.transparent;
    }
  }

  // 更新单元格状态
  void toggleState(String box, DateTime date) {
    String key = formatDate(date, [yyyy, mm, dd]);
    if (getState(box, date)) {
      getBox(box).value.delete(key);
    } else {
      getBox(box).value.put(key, true);
    }
    getBox(box).refresh();
  }
}