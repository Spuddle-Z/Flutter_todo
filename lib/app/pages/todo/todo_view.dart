import 'package:flutter/material.dart';

import 'package:to_do/app/pages/todo/widgets/my_calendar.dart';
import 'package:to_do/app/pages/todo/widgets/my_day.dart';

import 'package:to_do/core/theme.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: MyCalendar(),
          ),
          Expanded(child: MyDay()),
        ],
      ),
    );
  }
}
