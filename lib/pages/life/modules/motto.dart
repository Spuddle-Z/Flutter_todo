import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/pages/life/controller/hobbies_controller.dart';
import 'package:to_do/share/theme.dart';
import 'package:to_do/share/widgets/recessed_panel.dart';


class MottoWidget extends StatelessWidget {
  MottoWidget({super.key});

  final HobbiesController hobbiesController = Get.find<HobbiesController>();

  @override
  Widget build(BuildContext context) {
    return RecessedPanel(
      child: Row(
        children: [
          Expanded(
            child: Obx(() =>
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.backgroundDark,
                      AppColors.background,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      'Yesterday',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: hobbiesController.getSportsState(hobbiesController.today.value.subtract(const Duration(days: 1))),
                          onChanged: (value) => hobbiesController.toggleSportsState(hobbiesController.today.value.subtract(const Duration(days: 1))),
                        ),
                        const Text(
                          '运动',
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}