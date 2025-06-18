import 'package:flutter/material.dart';

import 'package:to_do/core/theme.dart';

class TaskConstant {
  /// 周期与优先级相关候选列表
  List<String> recurrenceTextList = ['不重复', '每天', '每周', '每月'];
  List<String> priorityTextList = ['闲白儿', '正事儿', '急茬儿'];
  List<IconData> priorityIconList = [
    Icons.coffee,
    Icons.event_note,
    Icons.error_outline,
  ];
  List<Color> priorityColorList = [
    AppColors.green,
    AppColors.primary,
    AppColors.red,
  ];
}
