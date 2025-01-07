import 'package:flutter/material.dart';
import '../theme.dart';
import '../widget/calendar.dart';
import '../widget/buttons.dart';
import '../widget/task_list.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('To Do'),
      ),
      body: Row(
        children: [
          Expanded(child: CalendarWidget(),
          ),
          Expanded(child: Column(
            children: [
              Container(
                child: ButtonsArea(),
              ),
              Expanded(
                child: TaskList(),
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