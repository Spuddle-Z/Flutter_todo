import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/data/models/item_model.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/shared/widgets/my_icon_button.dart';
import 'package:to_do/app/shared/widgets/my_text_button.dart';
import 'package:to_do/app/shared/widgets/my_text_field.dart';
import 'package:to_do/app/shared/widgets/date_text_field.dart';
import 'package:to_do/app/shared/widgets/dropdown_selector.dart';
import 'package:to_do/app/shared/constants/item_constant.dart';
import 'package:to_do/core/theme.dart';

class ItemPopupController extends GetxController {
  ItemPopupController({
    this.itemKey,
  });
  final int? itemKey;

  final MainController mainController = Get.find<MainController>();

  // 状态变量
  final RxString content = ''.obs;
  final RxString dateText = ''.obs;
  final RxnInt recurrenceIndex = RxnInt();
  final RxnInt priorityIndex = RxnInt();
  final RxnInt difficultyIndex = RxnInt();
  final RxString note = ''.obs;
  final RxBool isDateValid = false.obs;

  // 计算变量
  bool get isNewItem => itemKey == null;
  bool get isTask => dateText.isNotEmpty; // 是否为任务（有截止日期）
  bool get isContentValid => content.value.isNotEmpty;
  bool get isRecurrenceValid => recurrenceIndex.value != null;
  bool get isPriorityValid => priorityIndex.value != null;
  bool get isDifficultyValid => difficultyIndex.value != null;
  String get popupTitle {
    return '${isNewItem ? 'Add' : 'Edit'} ${isTask ? 'Task' : 'Trivia'}';
  }

  @override
  void onInit() {
    super.onInit();

    // 初始化事件
    if (isNewItem) {
      // 初始化一个新的事件
      dateText.value = '${DateTime.now().year}'
          '${DateTime.now().month.toString().padLeft(2, '0')}'
          '${DateTime.now().day.toString().padLeft(2, '0')}';
    } else {
      // 如果有键，则加载对应的事件
      Item item = mainController.itemBox.value.get(itemKey)!;
      content.value = item.content;
      dateText.value = item.isTask
          ? '${item.date!.year}'
              '${item.date!.month.toString().padLeft(2, '0')}'
              '${item.date!.day.toString().padLeft(2, '0')}'
          : '';
      recurrenceIndex.value = item.recurrence;
      priorityIndex.value = item.priority;
      difficultyIndex.value = item.difficulty;
      note.value = item.note;
    }
    isDateValid.value = true;
  }

  /// 更新任务内容
  String? onContentChanged(String input) {
    content.value = input;
    return isContentValid ? null : '任务内容不能为空';
  }

  /// 更新日期
  void onDateChanged(String input, bool isValid) {
    dateText.value = input;
    isDateValid.value = isValid;
  }

  /// 更新周期性
  String? onRecurrenceChanged(int? index) {
    recurrenceIndex.value = index;
    return isRecurrenceValid ? null : '请选择重复周期';
  }

  /// 更新优先级
  String? onPriorityChanged(int? index) {
    priorityIndex.value = index;
    return isPriorityValid ? null : '请选择优先级';
  }

  /// 更新难度
  String? onDifficultyChanged(int? index) {
    difficultyIndex.value = index;
    return isDifficultyValid ? null : '请选择难度';
  }

  /// 更新备注内容
  String? onNoteChanged(String input) {
    note.value = input;
    return null; // 备注内容不需要验证
  }

  /// 提交任务
  void onSubmit() {
    if (isTask &&
        isContentValid &&
        isDateValid.value &&
        isRecurrenceValid &&
        isPriorityValid) {
      Item newTask = Item(
        isTask: true,
        content: content.value,
        date: DateTime(
          int.parse(dateText.value.substring(0, 4)),
          int.parse(dateText.value.substring(4, 6)),
          int.parse(dateText.value.substring(6, 8)),
        ),
        recurrence: recurrenceIndex.value!,
        priority: priorityIndex.value!,
        note: note.value,
      );
      if (isNewItem) {
        mainController.addItem(newTask);
      } else {
        mainController.updateItem(itemKey!, newTask);
      }
      Get.back();
    } else if (!isTask && isContentValid && isDifficultyValid) {
      Item newTrivia = Item(
        isTask: false,
        content: content.value,
        difficulty: difficultyIndex.value!,
        note: note.value,
      );
      if (isNewItem) {
        mainController.addItem(newTrivia);
      } else {
        mainController.updateItem(itemKey!, newTrivia);
      }
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

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MyColors.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Obx(() {
                    return Text(
                      itemPopupController.popupTitle,
                      style: const TextStyle(
                        color: MyColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: MyIconButton(
                    icon: const Icon(Icons.close),
                    color: MyColors.text,
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
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
                    return itemPopupController.isTask
                        ? Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownSelector(
                                    initValue: itemPopupController
                                        .recurrenceIndex.value,
                                    isEnabled:
                                        itemPopupController.dateText.isNotEmpty,
                                    onChanged:
                                        itemPopupController.onRecurrenceChanged,
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
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: DropdownSelector(
                                    initValue:
                                        itemPopupController.priorityIndex.value,
                                    isEnabled: true,
                                    onChanged:
                                        itemPopupController.onPriorityChanged,
                                    optionList: List.generate(
                                      ItemConstant.priorityTextList.length,
                                      (index) => Row(
                                        children: [
                                          Icon(
                                            ItemConstant
                                                .priorityIconList[index],
                                            color: ItemConstant
                                                .priorityColorList[index],
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            ItemConstant
                                                .priorityTextList[index],
                                            style: TextStyle(
                                              color: ItemConstant
                                                  .priorityColorList[index],
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
                          )
                        : Expanded(
                            child: DropdownSelector(
                              initValue:
                                  itemPopupController.difficultyIndex.value,
                              isEnabled: true,
                              onChanged:
                                  itemPopupController.onDifficultyChanged,
                              optionList: List.generate(
                                ItemConstant.difficultyTextList.length,
                                (index) => Row(
                                  children: [
                                    Icon(
                                      ItemConstant.difficultyIconList[index],
                                      color: ItemConstant
                                          .difficultyColorList[index],
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      ItemConstant.difficultyTextList[index],
                                      style: TextStyle(
                                        color: ItemConstant
                                            .difficultyColorList[index],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              hintText: '请选择难度',
                            ),
                          );
                  }),
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
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyTextButton(
                  onPressed: itemPopupController.onSubmit,
                  icon: itemKey == null ? Icons.add : Icons.save,
                  text: itemKey == null ? 'Add' : 'Save',
                  color: MyColors.text,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
