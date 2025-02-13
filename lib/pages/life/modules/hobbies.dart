import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/pages/life/controller/hobbies_controller.dart';
import 'package:to_do/share/theme.dart';
import 'package:to_do/share/widgets/recessed_panel.dart';


class HobbiesWidget extends StatelessWidget {
  HobbiesWidget({super.key});

  final HobbiesController hobbiesController = Get.find<HobbiesController>();

  @override
  Widget build(BuildContext context) {
    return RecessedPanel(
      child: Column(
        children: [
          HobbiesHeader(hobbiesController: hobbiesController),
          HobbySports(hobbiesController: hobbiesController),
        ],
      ),
    );
  }
}

// 热力图标题栏
class HobbiesHeader extends StatelessWidget {
  const HobbiesHeader({
    super.key,
    required this.hobbiesController,
  });

  final HobbiesController hobbiesController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Row(
            children: [
              IconButton(
                onPressed: () => hobbiesController.updateViewYear(-1),
                icon: const Icon(Icons.keyboard_arrow_left),
                color: AppColors.text,
              ),
              Container(
                width: 80,
                alignment: Alignment.center,
                child: Obx(() =>
                  Text(
                    hobbiesController.viewYearString.value,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
              ),
              IconButton(
                onPressed: () => hobbiesController.updateViewYear(1),
                icon: const Icon(Icons.keyboard_arrow_right),
                color: AppColors.text,
              )
            ],
          ),
        ),
      ],
    );
  }
}

// 星期表头
class WeekdayHeader extends StatelessWidget {
  const WeekdayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        List<String> days = ['', 'Mon', '', 'Wed', '', 'Fri', ''];
        double width = constraints.maxWidth;
        double height = constraints.maxHeight / 7;
    
        return GridView.builder(
          itemCount: 7,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: width / height,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: width,
              alignment: Alignment.center,
              child: Text(
                days[index],
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        );
      }
    );
  }
}

// 运动模块
class HobbySports extends StatelessWidget {
  const HobbySports({
    super.key,
    required this.hobbiesController,
  });

  final HobbiesController hobbiesController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              'Sports',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 120,
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: WeekdayHeader()),
              Expanded(
                flex: 16,
                child: SportsHotMap(hobbiesController: hobbiesController)
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 运动热力图
class SportsHotMap extends StatelessWidget {
  const SportsHotMap({
    super.key,
    required this.hobbiesController,
  });

  final HobbiesController hobbiesController;

  @override
  Widget build(BuildContext context) {
    const int rows = 7;
    const int columns = 54;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double cellWidth = constraints.maxWidth / columns;
        double cellHeight = constraints.maxHeight / rows;
    
        return GridView.builder(
          itemCount: rows * columns,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: cellWidth / cellHeight,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Obx(() {
              Rx<DateTime> cellDate = hobbiesController.getCellDate(index).obs;
              final bool isToday = hobbiesController.isToday(cellDate.value);
              final bool isCurrentYear = hobbiesController.isCurrentYear(cellDate.value);
              final bool isMonthOdd = hobbiesController.isMonthOdd(cellDate.value);
              
              return Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isCurrentYear ? isMonthOdd ? AppColors.backgroundLight : AppColors.background : AppColors.backgroundDark,
                  border: Border.all(
                    color: isToday ? AppColors.textActive : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Container(
                  color: hobbiesController.getSportsColor(cellDate.value),
                ),
              );
            });
          }
        );
      }
    );
  }
}
