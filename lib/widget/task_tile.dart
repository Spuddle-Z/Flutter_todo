import 'package:flutter/material.dart';
import '../theme.dart';

class TaskTile extends StatelessWidget {
  final int taskIndex;
  final String taskContent;
  final bool taskDone;
  final int taskPriority;
  final Function(bool?)? onChanged;
  final Function() onDelete;

  const TaskTile({
    required this.taskIndex,
    required this.taskContent,
    required this.taskDone,
    required this.taskPriority,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Color tileColor;
    switch (taskPriority) {
      case 0:
        tileColor = AppColors.green;
        break;
      case 1:
        tileColor = AppColors.primary;
        break;
      case 2:
        tileColor = AppColors.red;
        break;
      default:
        tileColor = AppColors.textActive;
    }

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: tileColor.withAlpha(0x33),
          borderRadius: BorderRadius.circular(8),
          border: Border(
            top: BorderSide(color: tileColor, width: 3),
          ),
        ),
        child: Row(
          children: [
            Checkbox(
              value: taskDone,
              activeColor: tileColor,
              onChanged: onChanged,
            ),
            Text(
              taskContent,
              style: TextStyle(
                color: tileColor,
                fontSize: 16,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: tileColor,
              onPressed: () => onDelete(),
            ),
          ],
        ),
      ),
    );
  }
}