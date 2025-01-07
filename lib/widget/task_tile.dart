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
            CheckboxWidget(
              taskDone: taskDone, 
              tileColor: tileColor, 
              onChanged: onChanged
            ),
            Expanded(
              child:Text(
                taskContent,
                style: TextStyle(
                  color: tileColor,
                  fontSize: 16,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: tileColor,
              hoverColor: tileColor.withAlpha(0x33),
              onPressed: () => onDelete(),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({
    super.key,
    required this.taskDone,
    required this.tileColor,
    required this.onChanged,
  });

  final bool taskDone;
  final Color tileColor;
  final Function(bool? _)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: taskDone,
      activeColor: tileColor,
      checkColor: AppColors.background,
      hoverColor: tileColor.withAlpha(0x33),
      side: BorderSide(
        color: tileColor,
        width: 2,
      ),
      onChanged: onChanged,
    );
  }
}