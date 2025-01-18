import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/task_model.dart';
import '../theme.dart';


// 任务单元
class TaskTile extends StatelessWidget {
  final Task task;
  final int taskKey;
  final dynamic funcToggle;
  final dynamic funcDelete;
  final RxInt expandedKey;

  const TaskTile({
    super.key, 
    required this.task,
    required this.taskKey,
    required this.funcToggle,
    required this.funcDelete,
    required this.expandedKey,
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
      child: Obx(() => 
        Container(
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
                  // 勾选框
                  CheckboxWidget(
                    taskDone: task.taskDone, 
                    tileColor: tileColor, 
                    onChanged: (value) => funcToggle(taskKey),
                  ),

                  // 任务内容
                  Expanded(
                    child:Text(
                      task.taskContent,
                      style: TextStyle(
                        color: tileColor,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  // 展开备注按钮
                  if (task.taskNote.isNotEmpty)
                    TileButton(
                      icon: AnimatedRotation(
                        duration: const Duration(milliseconds: 300),
                        turns: expandedKey.value == taskKey ? 0.5 : 0,
                        child: const Icon(Icons.keyboard_arrow_down)),
                      color: tileColor,
                      onPressed: () {expandedKey.value = expandedKey.value == taskKey ? -1 : taskKey;},
                    ),

                  // 编辑按钮
                  TileButton(
                    icon: const Icon(Icons.edit),
                    color: tileColor,
                    onPressed: () => {},
                  ),
                  
                  // 删除按钮
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
                height: expandedKey.value == taskKey ? null : 0,
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
        ),
      ),
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

