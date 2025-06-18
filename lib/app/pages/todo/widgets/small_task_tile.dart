import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/app/data/models/task_model.dart';
import 'package:to_do/app/pages/todo/widgets/task_detail_popup.dart';
import 'package:to_do/app/shared/widgets/checkbox.dart';
import 'package:to_do/core/theme.dart';

// 任务单元
class SmallTaskTile extends StatelessWidget {
  final Task task;
  final int taskKey;
  final dynamic funcToggle;
  final dynamic funcDelete;
  final Color tileColor;

  const SmallTaskTile({
    super.key,
    required this.task,
    required this.taskKey,
    required this.funcToggle,
    required this.funcDelete,
    required this.tileColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          color: tileColor.withAlpha(0x33),
          borderRadius: BorderRadius.circular(4),
          border: Border(
            top: BorderSide(color: tileColor, width: 2),
          ),
        ),
        child: Row(
          children: [
            // 勾选框
            CheckboxWidget(
              taskDone: task.taskDone,
              tileColor: tileColor,
              scale: 0.6,
              onChanged: (value) => funcToggle(taskKey),
            ),

            // 任务内容
            Expanded(
              child: Text(
                task.taskContent,
                style: TextStyle(
                  color: tileColor,
                  fontSize: 12,
                  decoration: task.taskDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: tileColor,
                  decorationThickness: 2,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),

            // 超时天数
            if (tileColor == AppColors.textActive)
              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: AppColors.textActive,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "${-task.taskDate!.difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays}天前",
                  style: TextStyle(
                    color: AppColors.background.withAlpha(0xaa),
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            // 更多按钮
            SizedBox(
              width: 18,
              height: 18,
              child: IconButton(
                icon: const Icon(Icons.more_vert),
                color: tileColor,
                iconSize: 12,
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Get.dialog(
                    TaskDetailPopUp(
                      task: task,
                      taskKey: taskKey,
                      realToggle: () => funcToggle(taskKey),
                      funcDelete: () => funcDelete(taskKey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
