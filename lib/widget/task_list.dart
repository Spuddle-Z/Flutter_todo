import 'package:flutter/material.dart';
import 'task_tile.dart';

List testTaskList = [
  {
    'taskContent': 'Buy groceries',
    'taskDone': false,
    'taskPriority': 2,
  },
  {
    'taskContent': 'Walk the dog',
    'taskDone': false,
    'taskPriority': 1,
  },
  {
    'taskContent': 'Cook dinner',
    'taskDone': false,
    'taskPriority': 0,
  },
];

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
    return ListView.builder(
      itemCount: testTaskList.length,
      itemBuilder: (context, index) {
        return TaskTile(
          taskContent: testTaskList[index]['taskContent'],
          taskDone: testTaskList[index]['taskDone'],
          taskPriority: testTaskList[index]['taskPriority'],
        );
      },
    );
  }
}

class TasksNoDeadline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: testTaskList.length,
      itemBuilder: (context, index) {
        return TaskTile(
          taskContent: testTaskList[index]['taskContent'],
          taskDone: testTaskList[index]['taskDone'],
          taskPriority: testTaskList[index]['taskPriority'],
        );
      },
    );
  }
}
