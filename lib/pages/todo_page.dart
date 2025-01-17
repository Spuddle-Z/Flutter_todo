import 'package:flutter/material.dart';
import '../widget/calendar.dart';
import '../widget/buttons.dart';
import '../widget/task_list.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CalendarWidget(),
          ),
          const Expanded(child: Column(
            children: [
              ButtonsArea(),
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