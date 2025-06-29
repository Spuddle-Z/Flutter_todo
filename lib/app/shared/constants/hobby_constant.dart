import 'package:flutter/material.dart';
import 'package:to_do/core/theme.dart';

class HobbyConstant {
  static const List<String> hobbyTitleList = [
    'Schedule',
    'Sports',
    'Relax',
  ];
  static const List<List<String>> hobbyTextList = [
    ['Early Rise', 'Early Sleep'],
    ['Sports'],
    ['Relax'],
  ];
  static const List<Color> hobbyColorList = [
    AppColors.primary,
    AppColors.green,
    AppColors.purple,
  ];
  static const int hotMapRows = 7;
  static const int hotMapColumns = 54;
}
