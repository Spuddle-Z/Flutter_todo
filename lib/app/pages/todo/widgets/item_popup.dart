import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/data/models/task_model.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/shared/widgets/my_text_field.dart';
import 'package:to_do/app/shared/widgets/date_text_field.dart';
import 'package:to_do/app/shared/widgets/dropdown_selector.dart';
import 'package:to_do/app/shared/constants/item_constant.dart';
import 'package:to_do/core/theme.dart';

class ItemPopupController extends GetxController {
  ItemPopupController({
    required this.itemKey,
  });
  final int? itemKey;

  final MainController mainController = Get.find<MainController>();

  // 状态变量
  final RxString content = ''.obs;
  final RxString dateText = ''.obs;
  final RxnInt recurrenceIndex = RxnInt();
  final RxnInt priorityIndex = RxnInt();
  final RxString note = ''.obs;
  final RxBool isContentValid = false.obs;
  final RxBool isDateValid = false.obs;
  final RxBool isRecurrenceValid = false.obs;
  final RxBool isPriorityValid = false.obs;

  @override
  void onInit() {
    super.onInit();

    // 初始化任务
    if (itemKey != null) {
      // 如果有任务键，则加载对应的任务
      Task task = mainController.taskBox.value.get(itemKey)!;
      content.value = task.content;
      dateText.value = (task.date != null)
          ? '${task.date!.year}'
              '${task.date!.month.toString().padLeft(2, '0')}'
              '${task.date!.day.toString().padLeft(2, '0')}'
          : '';
      recurrenceIndex.value = task.recurrence;
      priorityIndex.value = task.priority;
      note.value = task.note;
      isContentValid.value = true;
      isDateValid.value = true;
      isRecurrenceValid.value = true;
      isPriorityValid.value = true;
    } else {
      // 如果没有任务键，则初始化一个新的任务
      content.value = '';
      dateText.value = '${DateTime.now().year}'
          '${DateTime.now().month.toString().padLeft(2, '0')}'
          '${DateTime.now().day.toString().padLeft(2, '0')}';
      recurrenceIndex.value = 0;
      priorityIndex.value = 0;
      note.value = '';
      isContentValid.value = false;
      isDateValid.value = true;
      isRecurrenceValid.value = true;
      isPriorityValid.value = true;
    }
  }

  /// 更新任务内容并检查是否有效
  String? onContentChanged(String input) {
    content.value = input;
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
    note.value = input;
    return null; // 备注内容不需要验证
  }

  /// 提交任务
  void onSubmit() {
    if (isContentValid.value &&
        isDateValid.value &&
        isRecurrenceValid.value &&
        isPriorityValid.value) {
      Task newTask = Task(
        content: content.value,
        date: dateText.value.isNotEmpty
            ? DateTime(
                int.parse(dateText.value.substring(0, 4)),
                int.parse(dateText.value.substring(4, 6)),
                int.parse(dateText.value.substring(6, 8)),
              )
            : null,
        recurrence: recurrenceIndex.value!,
        priority: priorityIndex.value!,
        note: note.value,
      );
      if (itemKey != null) {
        mainController.taskBox.value.put(itemKey!, newTask);
      } else {
        mainController.taskBox.value.add(newTask);
      }
      mainController.taskBox.refresh();
      Get.back();
    }
  }
}

class ItemPopup extends StatelessWidget {
  /// ### 添加与修改任务弹窗
  ///
  /// 该弹窗用于添加或修改任务，包含任务内容、截止日期、周期性、优先级和备注等输入项。
  const ItemPopup({
    super.key,
    this.itemKey,
  });

  final int? itemKey;

  @override
  Widget build(BuildContext context) {
    final ItemPopupController itemPopupController =
        Get.put(ItemPopupController(itemKey: itemKey));

    return AlertDialog(
      title: Text(
        itemKey == null ? 'New Task' : 'Edit Task',
        style: const TextStyle(
          color: MyColors.primary,
        ),
      ),
      backgroundColor: MyColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            // 任务内容输入框
            MyTextField(
              initialText: itemPopupController.content.value,
              hintText: '又有嘛事儿？',
              isMultiLine: false,
              onChanged: itemPopupController.onContentChanged,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 日期输入框
                  Expanded(
                    child: DateTextField(
                      initialDate: itemPopupController.dateText.value,
                      onChanged: itemPopupController.onDateChanged,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 重复周期输入框
                  Obx(() {
                    if (itemPopupController.dateText.isNotEmpty) {
                      return Expanded(
                        child: DropdownSelector(
                          initValue: itemPopupController.recurrenceIndex.value,
                          isEnabled: itemPopupController.dateText.isNotEmpty,
                          onChanged: itemPopupController.onRecurrenceChanged,
                          optionList: List.generate(
                            ItemConstant.recurrenceTextList.length,
                            (index) => Text(
                              ItemConstant.recurrenceTextList[index],
                              style: const TextStyle(
                                color: MyColors.text,
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
                      initValue: itemPopupController.priorityIndex.value,
                      isEnabled: true,
                      onChanged: itemPopupController.onPriorityChanged,
                      optionList: List.generate(
                        ItemConstant.priorityTextList.length,
                        (index) => Row(
                          children: [
                            Icon(
                              ItemConstant.priorityIconList[index],
                              color: ItemConstant.priorityColorList[index],
                            ),
                            Text(
                              ItemConstant.priorityTextList[index],
                              style: TextStyle(
                                color: ItemConstant.priorityColorList[index],
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
              child: MyTextField(
                initialText: itemPopupController.note.value,
                hintText: '备注：',
                isMultiLine: true,
                onChanged: itemPopupController.onNoteChanged,
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
            itemPopupController.onSubmit();
          },
          style: textButtonStyle(),
          child: Text(itemKey == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}
