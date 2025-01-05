import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'theme.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime selectedDay;
  final ValueChanged<DateTime> onDaySelected;

  CalendarWidget({required this.selectedDay, required this.onDaySelected});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2000, 1, 1),
      lastDay: DateTime.utc(2100, 12, 31),
      focusedDay: selectedDay,
      selectedDayPredicate: (day) => isSameDay(day, selectedDay),
      onDaySelected: (selectedDay, focusedDay) {
        onDaySelected(selectedDay);  // 调用回调函数，更新选中的日期
      },

      calendarStyle: const CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: AppColors.backgroundActive,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(
          color: AppColors.text,
        ),
        todayDecoration: BoxDecoration(
          color: AppColors.backgroundLight,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(
          color: AppColors.textActive,
          fontWeight: FontWeight.bold,
        ),
        weekendTextStyle: TextStyle(
          color: AppColors.textDark,
        ),
        defaultTextStyle: TextStyle(
          color: AppColors.text,
        ),
        outsideTextStyle: TextStyle(
          color: AppColors.textDark,
        ),
      ),

      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          color: AppColors.text,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        leftChevronIcon: Icon(
          Icons.arrow_left,
          color: AppColors.text,
        ),
        rightChevronIcon: Icon(
          Icons.arrow_right,
          color: AppColors.text,
        ),
      ),
    );
  }
}
