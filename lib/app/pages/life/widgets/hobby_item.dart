import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/shared/widgets/my_checkbox.dart';
import 'package:to_do/app/shared/constants/hobby_constant.dart';
import 'package:to_do/core/theme.dart';

class HobbyItemController extends GetxController {
  HobbyItemController({
    required this.hobbyIndexI,
    required this.hobbyIndexJ,
    required this.date,
  });
  final int hobbyIndexI;
  final int hobbyIndexJ;
  final DateTime date;

  final MainController mainController = Get.find<MainController>();

  /// 获取兴趣爱好状态
  bool getHobbyState() {
    return mainController.hobbyBoxes[hobbyIndexI][hobbyIndexJ].value
            .get(formatDate(date, [yyyy, mm, dd])) !=
        null;
  }

  // 更新单元格状态
  void toggleHobbyState() {
    String key = formatDate(date, [yyyy, mm, dd]);
    if (getHobbyState()) {
      mainController.hobbyBoxes[hobbyIndexI][hobbyIndexJ].value.delete(key);
    } else {
      mainController.hobbyBoxes[hobbyIndexI][hobbyIndexJ].value.put(key, true);
    }
    mainController.hobbyBoxes[hobbyIndexI][hobbyIndexJ].refresh();
  }
}

class HobbyItem extends StatelessWidget {
  /// ### 兴趣爱好项组件
  ///
  /// 该组件用于显示单个兴趣爱好项，包括勾选框和文本。
  const HobbyItem({
    super.key,
    required this.hobbyIndexI,
    required this.hobbyIndexJ,
    required this.date,
  });
  final int hobbyIndexI;
  final int hobbyIndexJ;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final HobbyItemController hobbyItemController = Get.put(
        HobbyItemController(
          hobbyIndexI: hobbyIndexI,
          hobbyIndexJ: hobbyIndexJ,
          date: date,
        ),
        tag:
            'hobbyItemController $hobbyIndexI-$hobbyIndexJ ${date.toIso8601String()}');

    return Row(
      children: [
        Obx(() {
          return MyCheckbox(
            done: hobbyItemController.getHobbyState(),
            color: HobbyConstant.hobbyColorList[hobbyIndexI],
            scale: 1,
            onChanged: (value) => hobbyItemController.toggleHobbyState(),
          );
        }),
        Text(
          HobbyConstant.hobbyTextList[hobbyIndexI][hobbyIndexJ],
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
