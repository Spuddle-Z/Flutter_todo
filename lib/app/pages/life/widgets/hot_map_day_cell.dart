import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/app/shared/constants/hobby_constant.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/pages/life/life_controller.dart';
import 'package:to_do/core/theme.dart';
import 'package:to_do/core/utils.dart';

class HotMapDayCellController extends GetxController {
  HotMapDayCellController({
    required this.index,
    required this.hobbyIndex,
  });
  final int index;
  final int hobbyIndex;

  final MainController mainController = Get.find<MainController>();
  final LifeController lifeController = Get.find<LifeController>();

  // 计算变量
  DateTime get cellDate {
    // 获取单元格对应的日期
    final int row = index ~/ 54;
    final int col = index % 54;
    final int offset = 7 * col + row - lifeController.firstDayIndex;
    return DateTime(lifeController.viewYear.value).add(Duration(days: offset));
  }

  bool get isToday =>
      isSameDay(cellDate, mainController.today.value); // 判断本单元格日期是否为今天
  bool get isCurrentYear =>
      cellDate.year == lifeController.viewYear.value; // 判断本单元格日期是否为当前年份
  bool get isMonthOdd => cellDate.month % 2 == 1; // 判断本单元格日期是否为奇数月份
  List<Color> get isHobbyActive {
    // 获取当前单元格日期对应的爱好状态
    return mainController.hobbyBoxes[hobbyIndex].map((box) {
      return box.value.get(formatDate(cellDate, [yyyy, mm, dd])) != null &&
              isCurrentYear
          ? HobbyConstant.hobbyColorList[hobbyIndex]
          : Colors.transparent;
    }).toList();
  }
}

class HotMapDayCell extends StatelessWidget {
  /// ### 热力图单元格组件
  ///
  /// 该组件用于显示热力图中的单个日期单元格。
  const HotMapDayCell({
    super.key,
    required this.index,
    required this.hobbyIndex,
  });
  final int index;
  final int hobbyIndex;

  @override
  Widget build(BuildContext context) {
    final HotMapDayCellController hotMapDayCellController = Get.put(
        HotMapDayCellController(index: index, hobbyIndex: hobbyIndex),
        tag: 'hotMapDayCellController_$hobbyIndex _$index');

    return Obx(() {
      return Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: hotMapDayCellController.isCurrentYear
              ? hotMapDayCellController.isMonthOdd
                  ? MyColors.backgroundLight
                  : MyColors.background
              : MyColors.backgroundDark,
          border: Border.all(
            color: hotMapDayCellController.isCurrentYear &&
                    hotMapDayCellController.isToday
                ? MyColors.textActive
                : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: List.generate(
                hotMapDayCellController.isHobbyActive.length * 2,
                (index) => hotMapDayCellController.isHobbyActive[index ~/ 2],
              ),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      );
    });
  }
}
