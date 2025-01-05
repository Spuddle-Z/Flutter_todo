import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: TasksToday()),
      ],
    );
  }
}

class TasksToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TaskItem(title: 'Buy groceries'),
        TaskItem(title: 'Walk the dog'),
        TaskItem(title: 'Cook dinner'),
      ],
    );
  }
}

class TaskItem extends StatelessWidget {
  final String title;

  TaskItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
    );
  }
}
