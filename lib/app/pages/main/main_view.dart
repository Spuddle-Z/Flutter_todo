import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/pages/todo/todo_view.dart';
import 'package:to_do/app/pages/life/life_view.dart';
import 'package:to_do/app/pages/main/widgets/navigation_bar_button.dart';

import 'package:to_do/core/theme.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  final MainController mainController = Get.find<MainController>();

  // 子页面
  final List<Widget> pages = [
    const TodoView(),
    const LifeView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Row(
          children: [
            // 导航栏
            Container(
              width: 80,
              color: AppColors.backgroundDark,
              child: Column(
                children: [
                  NavigationBarButton(
                    icon: Icons.calendar_month,
                    label: 'To Do',
                    isActive: mainController.currentIndex.value == 0,
                    onTap: () => mainController.currentIndex.value = 0,
                  ),
                  NavigationBarButton(
                    icon: Icons.coffee,
                    label: 'Life',
                    isActive: mainController.currentIndex.value == 1,
                    onTap: () => mainController.currentIndex.value = 1,
                  ),
                ],
              ),
            ),
            // 主内容区域
            Expanded(
              child: IndexedStack(
                index: mainController.currentIndex.value,
                children: pages,
              ),
            ),
          ],
        );
      }),
    );
  }
}
