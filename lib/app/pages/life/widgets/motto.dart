import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/life/controller/hobbies_controller.dart';
import 'package:to_do/core/theme.dart';
import 'package:to_do/app/shared/widgets/recessed_panel.dart';


class MottoWidget extends StatelessWidget {
  MottoWidget({super.key});

  final HobbiesController hobbiesController = Get.find<HobbiesController>();

  @override
  Widget build(BuildContext context) {
    final List<String> hobbies = ['Sports', 'Relax', 'Early Rise', 'Early Sleep'];
    final List<Color> colors = [AppColors.green, AppColors.purple, AppColors.primary, AppColors.primary];

    return RecessedPanel(
      child: Row(
        children: [
          Expanded(
            child: HobbiesList(
              hobbiesController: hobbiesController,
              hobbies: hobbies,
              colors: colors,
              isToday: false,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: HobbiesList(
              hobbiesController: hobbiesController,
              hobbies: hobbies,
              colors: colors,
              isToday: true,
            ),
          ),
        ],
      ),
    );
  }
}

class HobbiesList extends StatelessWidget {
  const HobbiesList({
    super.key,
    required this.hobbiesController,
    required this.hobbies,
    required this.colors,
    required this.isToday,
  });

  final HobbiesController hobbiesController;
  final List<String> hobbies;
  final List<Color> colors;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: isToday ?
        BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
        ) : 
        BoxDecoration(
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
            isToday ? 'Today' : 'Yesterday',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: hobbies.length,
              itemBuilder: (context, index) {
                return HobbyItem(
                  text: hobbies[index],
                  color: colors[index],
                  date: hobbiesController.today.value.subtract(Duration(days: isToday ? 0 : 1)),
                  funcGet: hobbiesController.getState,
                  funcToggle: hobbiesController.toggleState,
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

class HobbyItem extends StatelessWidget {
  const HobbyItem({
    super.key,
    required this.text,
    required this.color,
    required this.date,
    required this.funcGet,
    required this.funcToggle,
  });

  final String text;
  final Color color;
  final DateTime date;
  final Function(String, DateTime) funcGet;
  final Function(String, DateTime) funcToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() =>
          Checkbox(
            value: funcGet(text, date),
            activeColor: color,
            checkColor: AppColors.background,
            hoverColor: color.withAlpha(0x33),
            side: const BorderSide(
              color: AppColors.textDark,
              width: 2,
            ),
            onChanged: (value) => funcToggle(text, date),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
