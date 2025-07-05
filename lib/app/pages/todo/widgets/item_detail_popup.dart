import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';

import 'package:to_do/app/pages/todo/widgets/detail_tile.dart';
import 'package:to_do/app/pages/todo/widgets/item_popup.dart';

import 'package:to_do/app/data/models/task_model.dart';
import 'package:to_do/app/shared/constants/item_constant.dart';
import 'package:to_do/app/shared/widgets/my_checkbox.dart';
import 'package:to_do/app/shared/widgets/my_icon_button.dart';
import 'package:to_do/app/shared/widgets/my_text_button.dart';
import 'package:to_do/core/theme.dart';

class ItemDetailPopupController extends GetxController {
  ItemDetailPopupController({
    required this.itemKey,
  });
  final int itemKey;

  final MainController mainController = Get.find<MainController>();

  // 计算变量
  Task get task => mainController.taskBox.value.get(itemKey)!; // 任务数据

  /// 切换任务完成状态
  void onTaskToggled(done) {
    task.done = done!;
    mainController.updateTask(itemKey, task);
  }

  /// 删除任务
  void onTaskDeleted() {
    mainController.deleteTask(itemKey);
  }
}

class ItemDetailPopUp extends StatelessWidget {
  /// ### 任务详情弹窗
  ///
  /// 该弹窗用于显示任务的详细信息。
  const ItemDetailPopUp({
    super.key,
    required this.itemKey,
  });
  final int itemKey;

  @override
  Widget build(BuildContext context) {
    final ItemDetailPopupController itemDetailPopupController =
        Get.put(ItemDetailPopupController(itemKey: itemKey));

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        decoration: BoxDecoration(
          color: MyColors.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() {
                        return MyCheckbox(
                          done: itemDetailPopupController.task.done,
                          color: MyColors.primary,
                          activeColor: MyColors.primary,
                          scale: 1.2,
                          onChanged: itemDetailPopupController.onTaskToggled,
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          itemDetailPopupController.task.content,
                          style: const TextStyle(
                            color: MyColors.primary,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  MyIconButton(
                    icon: const Icon(Icons.close),
                    color: MyColors.text,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              DetailTile(
                keyText: 'Deadline',
                valueWidget: Text(
                  '${itemDetailPopupController.task.date!.year} 年 ${itemDetailPopupController.task.date!.month} 月 ${itemDetailPopupController.task.date!.day} 日',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: MyColors.text,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: DetailTile(
                      keyText: 'Recurrence',
                      valueWidget: Text(
                        ItemConstant.recurrenceTextList[
                            itemDetailPopupController.task.recurrence],
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: MyColors.text,
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
                            ItemConstant.priorityIconList[
                                itemDetailPopupController.task.priority],
                            color: ItemConstant.priorityColorList[
                                itemDetailPopupController.task.priority],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              ItemConstant.priorityTextList[
                                  itemDetailPopupController.task.priority],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: ItemConstant.priorityColorList[
                                    itemDetailPopupController.task.priority],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // if (itemDetailPopupController.task.note.isNotEmpty)
              //   DetailTile(
              //     keyText: 'Note',
              //     valueWidget: SingleChildScrollView(
              //       child: SelectableText(
              //         itemDetailPopupController.task.note,
              //         textAlign: TextAlign.left,
              //         style: const TextStyle(
              //           color: MyColors.text,
              //         ),
              //       ),
              //     ),
              //     isExpanded: true,
              //   ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyTextButton(
                    icon: Icons.delete,
                    text: 'Delete',
                    onPressed: () {
                      itemDetailPopupController.onTaskDeleted();
                      Get.back();
                    },
                    color: MyColors.red,
                  ),
                  MyTextButton(
                    icon: Icons.edit,
                    text: 'Edit',
                    onPressed: () {
                      Get.back();
                      Get.dialog(
                        ItemPopup(itemKey: itemKey),
                        barrierDismissible: false,
                      );
                    },
                    color: MyColors.text,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
