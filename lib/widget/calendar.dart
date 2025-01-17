import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/calendar_controller.dart';
import 'recessed_panel.dart';
import '../theme.dart';


class CalendarWidget extends StatelessWidget {
  CalendarWidget({super.key});

  final CalendarController calendarController = Get.find<CalendarController>();

  @override
  Widget build(BuildContext context) {
    return RecessedPanel(
      child: Column(
        children: [
          CalendarHeader(calendarController: calendarController,),
          const WeekdayHeader(),
          AdaptiveGrid(calendarController: calendarController),
        ],
      ),
    );
  }
}

// 日历标题栏
class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    super.key,
    required this.calendarController,
  });

  final CalendarController calendarController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.keyboard_arrow_left),
          color: AppColors.text,
        ),
        Obx(() => 
          Text(
            calendarController.viewMonthString.value,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.keyboard_arrow_right),
          color: AppColors.text,
        ),
      ],
    );
  }
}

// 星期标题栏
class WeekdayHeader extends StatelessWidget {
  const WeekdayHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
          double width = constraints.maxWidth / 7;
          double height = constraints.maxHeight;
      
          return GridView.builder(
            itemCount: 7,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: width / height,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: height,
                alignment: Alignment.center,
                child: Text(
                  days[index],
                  style: TextStyle(
                    color: index == 0 || index == 6 ? AppColors.textDark : AppColors.text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// 适应父组件大小的网格
class AdaptiveGrid extends StatelessWidget {
  const AdaptiveGrid({
    super.key,
    required this.calendarController,
  });

  final CalendarController calendarController;

  @override
  Widget build(BuildContext context) {
    const int rows = 6;
    const int columns = 7;

    return Expanded(
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
              return DayCell(
                index: index,
                calendarController: calendarController,
              );
            },
          );
        },
      ),
    );
  }
}

// 日历单元格
class DayCell extends StatelessWidget {
  DayCell({
    super.key,
    required this.index,
    required this.calendarController,
  });

  final int index;
  final CalendarController calendarController;

  @override
  Widget build(BuildContext context) {
    DateTime date = calendarController.getCellDate(index);
    final bool isToday = date.day == calendarController.today.value.day &&
      date.month == calendarController.today.value.month &&
      date.year == calendarController.today.value.year;
    final bool isCurrentMonth = date.month == calendarController.viewMonth.value.month;
    final bool isWeekend = date.weekday == 7 || date.weekday == 6;

    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isToday ? AppColors.backgroundLight : isCurrentMonth ? AppColors.background : AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '${date.day}',
        style: TextStyle(
          color: isToday ? AppColors.textActive : isWeekend ? AppColors.textDark : AppColors.text,
        ),
      ),
    );
  }
}
