import 'package:flutter/material.dart';
import 'package:to_do/core/theme.dart';

class ItemConstant {
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
    MyColors.green,
    MyColors.primary,
    MyColors.red,
  ];
  static const List<String> difficultyTextList = [
    '闭着眼都能做',
    '不占太多精力',
    '短时间内费脑',
    '如同创作',
  ];
  static const List<IconData> difficultyIconList = [
    Icons.hotel,
    Icons.music_note,
    Icons.my_location,
    Icons.smoking_rooms,
  ];
  static const List<Color> difficultyColorList = [
    MyColors.green,
    MyColors.blue,
    MyColors.purple,
    MyColors.red,
  ];
}
