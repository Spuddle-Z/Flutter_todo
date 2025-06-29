import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/shared/widgets/my_checkbox.dart';
import 'package:to_do/app/shared/constants/hobby_constant.dart';
import 'package:to_do/core/theme.dart';

class HobbyItemController extends GetxController {
  HobbyItemController({
    required this.i,
    required this.j,
    required this.date,
  });
  final int i;
  final int j;
  final DateTime date;

  final MainController mainController = Get.find<MainController>();

  /// 获取兴趣爱好状态
  bool getHobbyState() {
    return mainController.hobbyBoxes[i][j].value
            .get(formatDate(date, [yyyy, mm, dd])) !=
        null;
  }

  // 更新单元格状态
  void toggleHobbyState() {
    String key = formatDate(date, [yyyy, mm, dd]);
    if (getHobbyState()) {
      mainController.hobbyBoxes[i][j].value.delete(key);
    } else {
      mainController.hobbyBoxes[i][j].value.put(key, true);
    }
    mainController.hobbyBoxes[i][j].refresh();
  }
}

class HobbyItem extends StatelessWidget {
  /// ### 兴趣爱好项组件
  ///
  /// 该组件用于显示单个兴趣爱好项，包括勾选框和文本。
  const HobbyItem({
    super.key,
    required this.i,
    required this.j,
    required this.date,
  });
  final int i;
  final int j;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final HobbyItemController hobbyItemController = Get.put(
        HobbyItemController(i: i, j: j, date: date),
        tag: 'hobbyItemController $i-$j ${date.toIso8601String()}');

    return Row(
      children: [
        Obx(() {
          return MyCheckbox(
            done: hobbyItemController.getHobbyState(),
            color: HobbyConstant.hobbyColorList[i],
            scale: 1,
            onChanged: (value) => hobbyItemController.toggleHobbyState(),
          );
        }),
        Text(
          HobbyConstant.hobbyTextList[i][j],
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
