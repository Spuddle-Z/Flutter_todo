import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';

import 'package:to_do/app/pages/todo/widgets/detail_tile.dart';
import 'package:to_do/app/pages/todo/widgets/task_popup.dart';

import 'package:to_do/app/data/models/task_model.dart';
import 'package:to_do/app/shared/constants/task_constant.dart';
import 'package:to_do/app/shared/widgets/my_checkbox.dart';
import 'package:to_do/core/theme.dart';

class TaskDetailPopupController extends GetxController {
  TaskDetailPopupController({
    required this.taskKey,
  });
  final int taskKey;

  final MainController mainController = Get.find<MainController>();

  // 计算变量
  Rx<Task> get task => mainController.taskBox.value.get(taskKey)!.obs; // 任务数据

  /// 切换任务完成状态
  void onTaskToggled(done) {
    task.value.taskDone = done!;
    mainController.updateTask(taskKey, task.value);
  }

  /// 删除任务
  void onTaskDeleted() {
    mainController.deleteTask(taskKey);
  }
}

class TaskDetailPopUp extends StatelessWidget {
  /// ### 任务详情弹窗
  ///
  /// 该弹窗用于显示任务的详细信息。
  const TaskDetailPopUp({
    super.key,
    required this.taskKey,
  });
  final int taskKey;

  @override
  Widget build(BuildContext context) {
    final TaskDetailPopupController taskDetailPopupController =
        Get.put(TaskDetailPopupController(taskKey: taskKey));

    return AlertDialog(
      title: Row(
        children: [
          Obx(() {
            return MyCheckbox(
              done: taskDetailPopupController.task.value.taskDone,
              color: AppColors.primary,
              scale: 1.2,
              onChanged: taskDetailPopupController.onTaskToggled,
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              taskDetailPopupController.task.value.taskContent,
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
                '${taskDetailPopupController.task.value.taskDate!.year} 年 ${taskDetailPopupController.task.value.taskDate!.month} 月 ${taskDetailPopupController.task.value.taskDate!.day} 日',
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
                      TaskConstant.recurrenceTextList[
                          taskDetailPopupController.task.value.taskRecurrence],
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
                          TaskConstant.priorityIconList[
                              taskDetailPopupController
                                  .task.value.taskPriority],
                          color: TaskConstant.priorityColorList[
                              taskDetailPopupController
                                  .task.value.taskPriority],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            TaskConstant.priorityTextList[
                                taskDetailPopupController
                                    .task.value.taskPriority],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: TaskConstant.priorityColorList[
                                  taskDetailPopupController
                                      .task.value.taskPriority],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (taskDetailPopupController.task.value.taskNote.isNotEmpty)
              DetailTile(
                keyText: 'Note',
                valueWidget: SingleChildScrollView(
                  child: SelectableText(
                    taskDetailPopupController.task.value.taskNote,
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
            taskDetailPopupController.onTaskDeleted();
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
