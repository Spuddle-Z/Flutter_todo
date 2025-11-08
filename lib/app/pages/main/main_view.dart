import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/pages/todo/todo_view.dart';
import 'package:to_do/app/pages/life/life_view.dart';
import 'package:to_do/app/pages/core/core_view.dart';
import 'package:to_do/app/pages/main/widgets/navigation_bar_button.dart';
import 'package:to_do/app/pages/todo/widgets/item_popup.dart';

import 'package:to_do/core/shortcuts/intents.dart';
import 'package:to_do/core/shortcuts/shortcuts.dart';
import 'package:to_do/core/theme.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  final MainController mainController = Get.find<MainController>();

  // 子页面
  final List<Widget> pages = [
    const TodoView(),
    const LifeView(),
    const CoreView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shortcuts(
        shortcuts: shortcuts,
        child: Actions(
          actions: {
            ToTodoIntent: CallbackAction<ToTodoIntent>(
              onInvoke: (intent) {
                mainController.currentIndex.value = 0;
                return null;
              },
            ),
            ToLifeIntent: CallbackAction<ToLifeIntent>(
              onInvoke: (intent) {
                mainController.currentIndex.value = 1;
                return null;
              },
            ),
            ToCoreIntent: CallbackAction<ToCoreIntent>(
              onInvoke: (intent) {
                mainController.currentIndex.value = 2;
                return null;
              },
            ),
            AddItemIntent: CallbackAction<AddItemIntent>(
              onInvoke: (intent) {
                Get.dialog(
                  const ItemPopup(),
                );
                return null;
              },
            ),
            ToggleFullScreenIntent: CallbackAction<ToggleFullScreenIntent>(
              onInvoke: (intent) {
                mainController.toggleFullScreen();
                return null;
              },
            ),
          },
          child: Focus(
            focusNode: mainController.focusNode,
            child: Obx(() {
              return Row(
                children: [
                  // 导航栏
                  Container(
                    width: 80,
                    color: MyColors.backgroundDark,
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
                        NavigationBarButton(
                          icon: Icons.code,
                          label: 'Core',
                          isActive: mainController.currentIndex.value == 2,
                          onTap: () => mainController.currentIndex.value = 2,
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
          ),
        ),
      ),
    );
  }
}
