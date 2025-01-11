import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/task_model.dart';
import '../theme.dart';


// 任务单元
class TaskTile extends StatelessWidget {
  final Task task;
  final int taskKey;
  final RxInt showKey;
  final dynamic funcToggle;
  final dynamic funcToggleExpand;
  final dynamic funcDelete;

  const TaskTile({
    super.key, 
    required this.task,
    required this.taskKey,
    required this.showKey,
    required this.funcToggle,
    required this.funcToggleExpand,
    required this.funcDelete,
  });

  @override
  Widget build(BuildContext context) {
    Color tileColor;
    switch (task.taskPriority) {
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
      child: Obx(() => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: tileColor.withAlpha(0x33),
          borderRadius: BorderRadius.circular(8),
          border: Border(
            top: BorderSide(color: tileColor, width: 3),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CheckboxWidget(
                  taskDone: task.taskDone, 
                  tileColor: tileColor, 
                  onChanged: (value) => funcToggle(taskKey),
                ),
                Expanded(
                  child:Text(
                    task.taskContent,
                    style: TextStyle(
                      color: tileColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (task.taskNote.isNotEmpty)
                  IconButton(
                    icon: AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: showKey.value == taskKey ? 0.5 : 0,
                      child: const Icon(Icons.keyboard_arrow_down)),
                    color: tileColor,
                    hoverColor: tileColor.withAlpha(0x33),
                    onPressed: () {funcToggleExpand(taskKey);},
                  ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: tileColor,
                  hoverColor: tileColor.withAlpha(0x33),
                  onPressed: () => {},
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: tileColor,
                  hoverColor: tileColor.withAlpha(0x33),
                  onPressed: () => funcDelete(taskKey),
                ),
              ],
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              height: showKey.value == taskKey ? 100 : 0,
              child: Text(
                task.taskNote,
                style: TextStyle(
                  color: tileColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),)
    );
  }
}

// 勾选框
class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({
    super.key,
    required this.taskDone,
    required this.tileColor,
    required this.onChanged,
  });

  final bool taskDone;
  final Color tileColor;
  final void Function(bool?)? onChanged;

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