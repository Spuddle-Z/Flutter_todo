import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/pages/life/controller/hobbies_controller.dart';
import 'package:to_do/pages/life/controller/hot_map_controller.dart';
import 'package:to_do/share/theme.dart';
import 'package:to_do/share/widgets/recessed_panel.dart';


class HotMapList extends StatelessWidget {
  HotMapList({super.key});

  final HotMapController hotMapController = Get.find<HotMapController>();
  final HobbiesController hobbiesController = Get.find<HobbiesController>();

  @override
  Widget build(BuildContext context) {
    return RecessedPanel(
      child: Column(
        children: [
          HotMapHeader(hotMapController: hotMapController),
          HotMapWidget(
            hotMapController: hotMapController,
            hobbiesController: hobbiesController,
            hobby: 'Schedule',
          ),
          HotMapWidget(
            hotMapController: hotMapController,
            hobbiesController: hobbiesController,
            hobby: 'Sports',
          ),
          HotMapWidget(
            hotMapController: hotMapController,
            hobbiesController: hobbiesController,
            hobby: 'Relax',
          ),
        ],
      ),
    );
  }
}

// 热力图标题栏
class HotMapHeader extends StatelessWidget {
  const HotMapHeader({
    super.key,
    required this.hotMapController,
  });

  final HotMapController hotMapController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Row(
            children: [
              IconButton(
                onPressed: () => hotMapController.updateViewYear(-1),
                icon: const Icon(Icons.keyboard_arrow_left),
                color: AppColors.text,
              ),
              Container(
                width: 80,
                alignment: Alignment.center,
                child: Obx(() =>
                  Text(
                    hotMapController.viewYearString.value,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
              ),
              IconButton(
                onPressed: () => hotMapController.updateViewYear(1),
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

// 热力图
class HotMapWidget extends StatelessWidget {
  const HotMapWidget({
    super.key,
    required this.hotMapController,
    required this.hobbiesController,
    required this.hobby,
  });

  final HotMapController hotMapController;
  final HobbiesController hobbiesController;
  final String hobby;

  @override
  Widget build(BuildContext context) {
    const int rows = 7;
    const int columns = 54;

    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              hobby,
              style: const TextStyle(
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
                child: LayoutBuilder(
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
                          Rx<DateTime> cellDate = hotMapController.getCellDate(index).obs;
                          final bool isToday = hotMapController.isToday(cellDate.value);
                          final bool isCurrentYear = hotMapController.isCurrentYear(cellDate.value);
                          final bool isMonthOdd = hotMapController.isMonthOdd(cellDate.value);
                          
                          return Container(
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: isCurrentYear ? isMonthOdd ? AppColors.backgroundLight : AppColors.background : AppColors.backgroundDark,
                              border: Border.all(
                                color: isToday ? AppColors.textActive : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: hobby == 'Schedule' ?
                              Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: hobbiesController.getColor('Early Rise', cellDate.value),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [hobbiesController.getColor('Early Rise', cellDate.value), hobbiesController.getColor('Early Sleep', cellDate.value)],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: hobbiesController.getColor('Early Sleep', cellDate.value),
                                    ),
                                  ),
                                ],
                              ) :
                              Container(
                                color: hobbiesController.getColor(hobby, cellDate.value),
                              ),
                          );
                        });
                      }
                    );
                  }
                ),
              ),
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
