import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/core/theme.dart';
import 'package:to_do/app/pages/life/widgets/hobby_item.dart';

class HobbyList extends StatelessWidget {
  /// ### 兴趣爱好列表组件
  ///
  /// 该组件用于显示兴趣爱好列表，包含今天和昨天的爱好状态。
  const HobbyList({
    super.key,
    required this.isToday,
  });
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: isToday
          ? BoxDecoration(
              color: MyColors.background,
              borderRadius: BorderRadius.circular(8),
            )
          : BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  MyColors.backgroundDark,
                  MyColors.background,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
      child: Column(
        children: [
          Text(
            isToday ? 'Today' : 'Yesterday',
            style: const TextStyle(
              color: MyColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: mainController.hobbyBoxes.length,
              itemBuilder: (context, i) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: mainController.hobbyBoxes[i].length,
                  itemBuilder: (context, j) {
                    return SizedBox(
                      width: Get.width,
                      child: HobbyItem(
                        hobbyIndexI: i,
                        hobbyIndexJ: j,
                        date: mainController.today.value
                            .subtract(Duration(days: isToday ? 0 : 1)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
