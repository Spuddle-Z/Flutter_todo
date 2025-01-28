import 'package:flutter/material.dart';

import '../modules/calendar.dart';
import '../modules/my_day.dart';


class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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