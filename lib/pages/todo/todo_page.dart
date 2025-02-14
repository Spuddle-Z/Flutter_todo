import 'package:flutter/material.dart';
import 'package:to_do/pages/todo/modules/calendar.dart';
import 'package:to_do/pages/todo/modules/my_day.dart';
import 'package:to_do/share/theme.dart';


class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CalendarWidget(),
          ),
          Expanded(child: TaskLists()),
        ],
      ),
    );
  }
}