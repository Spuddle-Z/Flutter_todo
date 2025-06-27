import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';

import 'package:to_do/app/pages/todo/widgets/task_detail_popup.dart';
import 'package:to_do/app/pages/todo/widgets/task_popup.dart';

import 'package:to_do/app/data/models/task_model.dart';
import 'package:to_do/app/shared/constants/task_constant.dart';
import 'package:to_do/app/shared/widgets/my_checkbox.dart';
import 'package:to_do/app/shared/widgets/my_icon_button.dart';
import 'package:to_do/core/theme.dart';

class TaskTileController extends GetxController {
  TaskTileController({
    required this.taskKey,
    this.cellDate,
  });
  final int taskKey;
  final DateTime? cellDate;

  final MainController mainController = Get.find<MainController>();

  // 状态变量
  final RxBool isExpanded = false.obs; // 用于控制备注的展开状态
  final Rx<Task> task = Task(
    taskContent: '',
    taskDate: null,
    taskRecurrence: 0,
    taskPriority: 0,
    taskNote: '',
  ).obs; // 任务数据

  // 计算变量
  Color get color {
    // 根据任务状态和截止日期计算颜色
    if (task.value.taskDone) {
      return AppColors.textDark;
    } else if (task.value.taskDate != null &&
        task.value.taskDate != cellDate &&
        task.value.taskDate!
            .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return AppColors.textActive;
    } else {
      return TaskConstant.priorityColorList[task.value.taskPriority];
    }
  } // 获取任务颜色

  @override
  void onInit() {
    super.onInit();

    task.value = mainController.taskBox.value.get(taskKey)!; // 获取任务数据
  }

  /// 切换任务完成状态
  void onTaskToggled(bool? done) {
    task.value.taskDone = done!;
    mainController.updateTask(taskKey, task.value);
  }

  /// 删除任务
  void onTaskDelete() {
    mainController.deleteTask(taskKey);
  }
}

class TaskTile extends StatelessWidget {
  /// ### 任务组件
  ///
  /// 该组件用于在任务列表或日历中显示单个任务的简要内容。
  const TaskTile({
    super.key,
    required this.taskKey,
    required this.isMiniTile,
    this.cellDate,
  });
  final int taskKey;
  final bool isMiniTile;
  final DateTime? cellDate;

  @override
  Widget build(BuildContext context) {
    final TaskTileController taskTileController = Get.put(
        TaskTileController(taskKey: taskKey, cellDate: cellDate),
        tag: 'taskTileController_$taskKey _$isMiniTile ${cellDate ?? ''}');

    return Padding(
      padding: EdgeInsets.all(isMiniTile ? 2 : 4),
      child: Container(
        decoration: BoxDecoration(
          color: taskTileController.color.withAlpha(0x33),
          borderRadius: BorderRadius.circular(isMiniTile ? 4 : 8),
          border: Border(
            top: BorderSide(
              color: taskTileController.color,
              width: isMiniTile ? 2 : 3,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                // 勾选框
                MyCheckbox(
                  done: taskTileController.task.value.taskDone,
                  color: taskTileController.color,
                  scale: isMiniTile ? 0.6 : 1,
                  onChanged: taskTileController.onTaskToggled,
                ),

                // 任务内容
                Expanded(
                  child: Text(
                    taskTileController.task.value.taskContent,
                    style: TextStyle(
                      color: taskTileController.color,
                      fontSize: isMiniTile ? 12 : 16,
                      decoration: taskTileController.task.value.taskDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: taskTileController.color,
                      decorationThickness: 2,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),

                // 超时天数
                if (taskTileController.color == AppColors.textActive)
                  Container(
                    padding: EdgeInsets.all(isMiniTile ? 1 : 2),
                    decoration: BoxDecoration(
                      color: AppColors.textActive,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "${-taskTileController.task.value.taskDate!.difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays}天前",
                      style: TextStyle(
                        color: AppColors.background.withAlpha(0xaa),
                        fontSize: isMiniTile ? 8 : 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                // 展开备注按钮
                if (!isMiniTile &&
                    taskTileController.task.value.taskNote.isNotEmpty)
                  MyIconButton(
                    icon: AnimatedRotation(
                        duration: const Duration(milliseconds: 300),
                        turns: taskTileController.isExpanded.value ? 0.5 : 0,
                        child: const Icon(Icons.keyboard_arrow_down)),
                    color: taskTileController.color,
                    onPressed: () {
                      taskTileController.isExpanded.value =
                          !taskTileController.isExpanded.value;
                    },
                  ),

                // 编辑按钮
                if (!isMiniTile)
                  MyIconButton(
                    icon: const Icon(Icons.edit),
                    color: taskTileController.color,
                    onPressed: () => {
                      Get.dialog(
                        TaskPopup(taskKey: taskKey),
                        barrierDismissible: false,
                      )
                    },
                  ),

                // 删除按钮
                if (!isMiniTile)
                  MyIconButton(
                    icon: const Icon(Icons.close),
                    color: taskTileController.color,
                    onPressed: taskTileController.onTaskDelete,
                  ),

                // 更多按钮
                if (isMiniTile)
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: IconButton(
                      icon: const Icon(Icons.more_vert),
                      color: taskTileController.color,
                      iconSize: 12,
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        Get.dialog(
                          TaskDetailPopUp(taskKey: taskKey),
                        );
                      },
                    ),
                  ),
              ],
            ),

            // 备注内容
            if (!isMiniTile)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                height:
                    taskTileController.isExpanded.value == taskKey ? null : 0,
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
                      taskTileController.task.value.taskNote,
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
    );
  }
}
