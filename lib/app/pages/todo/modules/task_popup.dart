import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/app/shared/widgets/text_field.dart';
import 'package:to_do/app/shared/widgets/date_text_field.dart';
import 'package:to_do/app/shared/widgets/dropdown_selector.dart';
import 'package:to_do/core/theme.dart';

class TaskPopupController extends GetxController {
  TaskPopupController({
    required this.taskKey,
  });
  final int? taskKey;

  // 暂存输入内容
  late RxString taskContent;
  late RxString dateText;
  late RxnInt recurrenceIndex;
  late RxnInt priorityIndex;
  late RxString taskNote;

  // 输入框合格性变量
  late RxBool isContentValid;
  late RxBool isDateValid;
  late RxBool isRecurrenceValid;
  late RxBool isPriorityValid;

  // 周期与优先级相关候选列表
  List<String> recurrenceTextList = ['不重复', '每天', '每周', '每月'];
  List<String> priorityTextList = ['闲白儿', '正事儿', '急茬儿'];
  List<IconData> priorityIconList = [
    Icons.coffee,
    Icons.event_note,
    Icons.error_outline,
  ];
  List<Color> priorityColorList = [
    AppColors.green,
    AppColors.primary,
    AppColors.red,
  ];

  @override
  void onInit() {
    super.onInit();

    // 初始化任务
    taskContent = ''.obs;
    dateText = '${DateTime.now().year}'
            '${DateTime.now().month.toString().padLeft(2, '0')}'
            '${DateTime.now().day.toString().padLeft(2, '0')}'
        .obs;
    recurrenceIndex = RxnInt();
    priorityIndex = RxnInt();
    taskNote = ''.obs;
    isContentValid = false.obs;
    isDateValid = false.obs;
    isRecurrenceValid = false.obs;
    isPriorityValid = false.obs;
  }

  // 更新任务内容并检查是否有效
  void onContentChanged(String input) {
    taskContent.value = input;
    isContentValid.value = input.isNotEmpty;
  }

  // 更新日期
  void onDateChanged(String input, bool isValid) {
    dateText.value = input;
    isDateValid.value = isValid;
  }

  // 更新周期性并检查是否有效
  void onRecurrenceChanged(int? index) {
    recurrenceIndex.value = index;
    isRecurrenceValid.value = index != null;
  }

  // 更新优先级并检查是否有效
  void onPriorityChanged(int? index) {
    priorityIndex.value = index;
    isPriorityValid.value = index != null;
  }
}

class TaskPopup extends StatelessWidget {
  /// 添加、修改任务时的弹出框
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
      title: const Text(
        'New Task',
        style: TextStyle(
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
            // ContentTextField(
            //   popUpController: popUpController,
            // ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  // 日期输入框
                  Expanded(
                    child: Obx(() {
                      return DateTextField(
                        dateText: taskPopupController.dateText.value,
                        onChanged: taskPopupController.onDateChanged,
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  // 重复周期输入框
                  Expanded(
                    child: Obx(() {
                      return DropdownSelector(
                        value: taskPopupController.recurrenceIndex.value,
                        isEnabled: taskPopupController.dateText.isNotEmpty,
                        onChanged: taskPopupController.onRecurrenceChanged,
                        optionList: List.generate(
                          taskPopupController.recurrenceTextList.length,
                          (index) => Text(
                            taskPopupController.recurrenceTextList[index],
                            style: const TextStyle(
                              color: AppColors.text,
                            ),
                          ),
                        ),
                        hintText: '请选择周期',
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Obx(() {
                      return DropdownSelector(
                        value: taskPopupController.priorityIndex.value,
                        isEnabled: true,
                        onChanged: taskPopupController.onPriorityChanged,
                        optionList: List.generate(
                          taskPopupController.priorityTextList.length,
                          (index) => Row(
                            children: [
                              Icon(
                                taskPopupController.priorityIconList[index],
                                color: taskPopupController
                                    .priorityColorList[index],
                              ),
                              Text(
                                taskPopupController.priorityTextList[index],
                                style: TextStyle(
                                  color: taskPopupController
                                      .priorityColorList[index],
                                ),
                              ),
                            ],
                          ),
                        ),
                        hintText: '请选择优先级',
                      );
                    }),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: NoteTextField(
            //     popUpController: popUpController,
            //   ),
            // ),
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
            if (taskPopupController.isContentValid.value &&
                taskPopupController.isDateValid.value &&
                taskPopupController.isRecurrenceValid.value &&
                taskPopupController.isPriorityValid.value) {
              Get.back();
            }
          },
          style: textButtonStyle(),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
