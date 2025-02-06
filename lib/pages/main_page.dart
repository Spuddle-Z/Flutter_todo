import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/util/routes.dart';
import 'package:to_do/util/navigation_controller.dart';

import 'package:to_do/theme.dart';


class MainPage extends StatelessWidget {
  MainPage({super.key});

  final NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          navigationBar(),
          Expanded(
            child: Navigator(
              key: Get.nestedKey(1),
              initialRoute: Routes.todo,
              onGenerateRoute: onGenerateRoute
            ),
          ),
        ],
      ),
    );
  }

  

  // 导航栏
  Widget navigationBar() {
    return Container(
      width: 80,
      color: AppColors.backgroundDark,
      child: Obx(() => Column(
        children: [
          NavButton(
            icon: Icons.calendar_month,
            label: 'To Do',
            isActive: controller.currentIndex.value == 0,
            onTap: () => controller.changePage(0),
          ),
          NavButton(
            icon: Icons.coffee,
            label: 'Life',
            isActive: controller.currentIndex.value == 1,
            onTap: () => controller.changePage(1),
          ),
        ],
      )),
    );
  }
}


class NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavButton({
    super.key, 
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 8,
          right: isActive ? 0 : 8,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isActive ? AppColors.background : Colors.transparent,
            boxShadow: isActive ? [
              BoxShadow(
                color: Colors.black.withAlpha(0x80),
                offset: const Offset(-4, 4),
                blurRadius: 6,
                spreadRadius: -4,
              ),
            ] : null,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive ? AppColors.primary : AppColors.textDark,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? AppColors.primary : AppColors.textDark,
                  fontSize: 12
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
