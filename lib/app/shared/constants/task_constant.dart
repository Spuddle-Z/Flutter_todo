import 'package:flutter/material.dart';

import 'package:to_do/core/theme.dart';

class TaskConstant {
  static const List<String> recurrenceTextList = [
    '不重复',
    '每天',
    '每周',
    '每月',
  ];
  static const List<String> priorityTextList = [
    '闲白儿',
    '正事儿',
    '急茬儿',
  ];
  static const List<IconData> priorityIconList = [
    Icons.coffee,
    Icons.event_note,
    Icons.error_outline,
  ];
  static const List<Color> priorityColorList = [
    AppColors.green,
    AppColors.primary,
    AppColors.red,
  ];
}
