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
        padding: const EdgeInsets.all(0),
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
                  TileButton(
                    icon: AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: showKey.value == taskKey ? 0.5 : 0,
                      child: const Icon(Icons.keyboard_arrow_down)),
                    color: tileColor,
                    onPressed: () {funcToggleExpand(taskKey);},
                  ),
                TileButton(
                  icon: const Icon(Icons.edit),
                  color: tileColor,
                  onPressed: () => {},
                ),
                TileButton(
                  icon: const Icon(Icons.close),
                  color: tileColor,
                  onPressed: () => funcDelete(taskKey),
                ),
              ],
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              height: showKey.value == taskKey ? 150 : 0,
              padding: const EdgeInsets.all(4),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.backgroundDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SelectableText(
                    task.taskNote,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),),
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
    return Transform.scale(
      scale: 0.8,
      child: Checkbox(
        value: taskDone,
        activeColor: tileColor,
        checkColor: AppColors.background,
        hoverColor: tileColor.withAlpha(0x33),
        side: BorderSide(
          color: tileColor,
          width: 2,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

// 任务单元上的各按钮
class TileButton extends IconButton {
  TileButton({
    super.key,
    required Widget icon,
    required Color color,
    required void Function() onPressed,
  }): super(
    icon: icon,
    color: color,
    hoverColor: color.withAlpha(0x33),
    iconSize: 16,
    constraints: const BoxConstraints(
      minWidth: 0,
      minHeight: 0,
    ),
    onPressed: onPressed,
  );
}

