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
    '简单',
    '中等',
    '困难',
  ];
  static const List<IconData> difficultyIconList = [
    Icons.sentiment_satisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_dissatisfied,
  ];
  static const List<Color> difficultyColorList = [
    MyColors.blue,
    MyColors.lemon,
    MyColors.purple,
  ];
}
