import 'package:flutter/material.dart';
import '../widget/calendar.dart';
import '../widget/buttons.dart';
import '../widget/task_list.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CalendarWidget(),
          ),
          Expanded(child: Column(
            children: [
              Container(
                child: ButtonsArea(),
              ),
              Expanded(
                child: TaskList(),
              ),
            ],
          )),
        ],
      ),
    );
  }
}