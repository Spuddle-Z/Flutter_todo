import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:to_do/app/data/models/task_model.dart';
import 'package:to_do/app/shared/widgets/my_text_field.dart';
import 'package:to_do/app/shared/widgets/date_text_field.dart';
import 'package:to_do/app/shared/widgets/dropdown_selector.dart';
import 'package:to_do/app/shared/constants/task_constant.dart';
import 'package:to_do/core/theme.dart';

class TaskPopupController extends GetxController {
  TaskPopupController({
    required this.taskKey,
  });
  final int? taskKey;

  // 状态变量
  final Rx<Box<Task>> taskBox = Hive.box<Task>('tasks').obs;
  final RxString taskContent = ''.obs;
  final RxString dateText = ''.obs;
  final RxnInt recurrenceIndex = RxnInt();
  final RxnInt priorityIndex = RxnInt();
  final RxString taskNote = ''.obs;
  final RxBool isContentValid = false.obs;
  final RxBool isDateValid = false.obs;
  final RxBool isRecurrenceValid = false.obs;
  final RxBool isPriorityValid = false.obs;

  @override
  void onInit() {
    super.onInit();

    // 初始化任务
    if (taskKey != null) {
      // 如果有任务键，则加载对应的任务
      Task task = taskBox.value.get(taskKey)!;
      taskContent.value = task.taskContent;
      dateText.value = (task.taskDate != null)
          ? '${task.taskDate!.year}'
              '${task.taskDate!.month.toString().padLeft(2, '0')}'
              '${task.taskDate!.day.toString().padLeft(2, '0')}'
          : '';
      recurrenceIndex.value = task.taskRecurrence;
      priorityIndex.value = task.taskPriority;
      taskNote.value = task.taskNote;
      isContentValid.value = true;
      isDateValid.value = true;
      isRecurrenceValid.value = true;
      isPriorityValid.value = true;
    } else {
      // 如果没有任务键，则初始化一个新的任务
      taskContent.value = '';
      dateText.value = '${DateTime.now().year}'
          '${DateTime.now().month.toString().padLeft(2, '0')}'
          '${DateTime.now().day.toString().padLeft(2, '0')}';
      recurrenceIndex.value = null;
      priorityIndex.value = null;
      taskNote.value = '';
      isContentValid.value = false;
      isDateValid.value = true;
      isRecurrenceValid.value = false;
      isPriorityValid.value = false;
    }
  }

  /// 更新任务内容并检查是否有效
  String? onContentChanged(String input) {
    taskContent.value = input;
    isContentValid.value = input.isNotEmpty;
    return isContentValid.value ? null : '任务内容不能为空';
  }

  /// 更新日期
  void onDateChanged(String input, bool isValid) {
    dateText.value = input;
    isDateValid.value = isValid;
  }

  /// 更新周期性并检查是否有效
  void onRecurrenceChanged(int? index) {
    recurrenceIndex.value = index;
    isRecurrenceValid.value = index != null;
  }

  /// 更新优先级并检查是否有效
  void onPriorityChanged(int? index) {
    priorityIndex.value = index;
    isPriorityValid.value = index != null;
  }

  /// 更新备注内容
  String? onNoteChanged(String input) {
    taskNote.value = input;
    return null; // 备注内容不需要验证
  }

  /// 提交任务
  void onSubmit() {
    if (isContentValid.value &&
        isDateValid.value &&
        isRecurrenceValid.value &&
        isPriorityValid.value) {
      Task newTask = Task(
        taskContent: taskContent.value,
        taskDate: dateText.value.isNotEmpty
            ? DateTime(
                int.parse(dateText.value.substring(0, 4)),
                int.parse(dateText.value.substring(4, 6)),
                int.parse(dateText.value.substring(6, 8)),
              )
            : null,
        taskRecurrence: recurrenceIndex.value!,
        taskPriority: priorityIndex.value!,
        taskNote: taskNote.value,
      );
      if (taskKey != null) {
        taskBox.value.put(taskKey!, newTask);
      } else {
        taskBox.value.add(newTask);
      }
      taskBox.refresh();
      Get.back();
    }
  }
}

class TaskPopup extends StatelessWidget {
  /// ### 添加与修改任务弹窗
  ///
  /// 该弹窗用于添加或修改任务，包含任务内容、截止日期、周期性、优先级和备注等输入项。
  const TaskPopup({
    super.key,
    this.taskKey,
  });

  final int? taskKey;

  @override
  Widget build(BuildContext context) {
    final TaskPopupController taskPopupController =
        Get.put(TaskPopupController(taskKey: taskKey));

    return AlertDialog(
      title: Text(
        taskKey == null ? 'New Task' : 'Edit Task',
        style: const TextStyle(
          color: AppColors.primary,
        ),
      ),
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            // 任务内容输入框
            ContentTextField(
              initialText: taskPopupController.taskContent.value,
              hintText: '又有嘛事儿？',
              isMultiLine: false,
              onChanged: taskPopupController.onContentChanged,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 日期输入框
                  Expanded(
                    child: DateTextField(
                      initialDate: taskPopupController.dateText.value,
                      onChanged: taskPopupController.onDateChanged,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 重复周期输入框
                  Obx(() {
                    if (taskPopupController.dateText.isNotEmpty) {
                      return Expanded(
                        child: DropdownSelector(
                          initValue: taskPopupController.recurrenceIndex.value,
                          isEnabled: taskPopupController.dateText.isNotEmpty,
                          onChanged: taskPopupController.onRecurrenceChanged,
                          optionList: List.generate(
                            TaskConstant.recurrenceTextList.length,
                            (index) => Text(
                              TaskConstant.recurrenceTextList[index],
                              style: const TextStyle(
                                color: AppColors.text,
                              ),
                            ),
                          ),
                          hintText: '请选择周期',
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownSelector(
                      initValue: taskPopupController.priorityIndex.value,
                      isEnabled: true,
                      onChanged: taskPopupController.onPriorityChanged,
                      optionList: List.generate(
                        TaskConstant.priorityTextList.length,
                        (index) => Row(
                          children: [
                            Icon(
                              TaskConstant.priorityIconList[index],
                              color: TaskConstant.priorityColorList[index],
                            ),
                            Text(
                              TaskConstant.priorityTextList[index],
                              style: TextStyle(
                                color: TaskConstant.priorityColorList[index],
                              ),
                            ),
                          ],
                        ),
                      ),
                      hintText: '请选择优先级',
                    ),
                  ),
                ],
              ),
            ),
            // 备注输入框
            Expanded(
              child: ContentTextField(
                initialText: taskPopupController.taskNote.value,
                hintText: '备注：',
                isMultiLine: true,
                onChanged: taskPopupController.onNoteChanged,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
          },
          style: textButtonStyle(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            taskPopupController.onSubmit();
          },
          style: textButtonStyle(),
          child: Text(taskKey == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}
