import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/app/pages/todo/widgets/detail_tile.dart';
import 'package:to_do/app/pages/todo/widgets/task_popup.dart';

import 'package:to_do/app/data/models/task_model.dart';
import 'package:to_do/app/shared/constants/task_constant.dart';
import 'package:to_do/app/shared/widgets/checkbox.dart';
import 'package:to_do/core/theme.dart';

class TaskDetailPopUp extends StatelessWidget {
  const TaskDetailPopUp({
    super.key,
    required this.task,
    required this.taskKey,
    required this.realToggle,
    required this.funcDelete,
  });

  final Task task;
  final int taskKey;
  final void Function() realToggle;
  final void Function() funcDelete;

  @override
  Widget build(BuildContext context) {
    RxBool fakeDone = task.taskDone.obs;

    return AlertDialog(
      title: Row(
        children: [
          Obx(
            () => CheckboxWidget(
              taskDone: fakeDone.value,
              tileColor: AppColors.primary,
              scale: 1.2,
              onChanged: (value) {
                fakeDone.value = !fakeDone.value;
                realToggle();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              task.taskContent,
              style: const TextStyle(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          children: [
            DetailTile(
              keyText: 'Deadline',
              valueWidget: Text(
                '${task.taskDate!.year} 年 ${task.taskDate!.month} 月 ${task.taskDate!.day} 日',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: AppColors.text,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: DetailTile(
                    keyText: 'Recurrence',
                    valueWidget: Text(
                      TaskConstant().recurrenceTextList[task.taskRecurrence],
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: AppColors.text,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: DetailTile(
                    keyText: 'Priority',
                    valueWidget: Row(
                      children: [
                        Icon(
                          TaskConstant().priorityIconList[task.taskPriority],
                          color: TaskConstant()
                              .priorityColorList[task.taskPriority],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            TaskConstant().priorityTextList[task.taskPriority],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: TaskConstant()
                                  .priorityColorList[task.taskPriority],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (task.taskNote.isNotEmpty)
              DetailTile(
                keyText: 'Note',
                valueWidget: SingleChildScrollView(
                  child: SelectableText(
                    task.taskNote,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: AppColors.text,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            funcDelete();
            Get.back();
          },
          style: textButtonStyle(),
          child: const Text('Delete'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            Get.dialog(
              TaskPopup(taskKey: taskKey),
              barrierDismissible: false,
            );
          },
          style: textButtonStyle(),
          child: const Text('Edit'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          style: textButtonStyle(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

// 任务信息表头
class InformationHead extends StatelessWidget {
  const InformationHead({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      width: 100,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}
