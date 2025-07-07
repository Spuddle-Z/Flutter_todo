import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';

import 'package:to_do/app/pages/todo/widgets/detail_tile.dart';
import 'package:to_do/app/pages/todo/widgets/item_popup.dart';

import 'package:to_do/app/data/models/item_model.dart';
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
  Item get item => mainController.itemBox.value.get(itemKey)!; // 任务数据

  /// 切换任务完成状态
  void onItemToggled(done) {
    item.done = done!;
    mainController.updateItem(itemKey, item);
  }

  /// 删除任务
  void onItemDeleted() {
    mainController.deleteItem(itemKey);
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
          maxWidth: MediaQuery.of(context).size.width * 0.5,
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
                  // 任务标题和完成状态
                  Row(
                    children: [
                      Obx(() {
                        return MyCheckbox(
                          done: itemDetailPopupController.item.done,
                          color: MyColors.primary,
                          activeColor: MyColors.primary,
                          scale: 1.2,
                          onChanged: itemDetailPopupController.onItemToggled,
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          itemDetailPopupController.item.content,
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
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              itemDetailPopupController.item.isTask
                  ? Column(
                      children: [
                        // 任务截止日期
                        DetailTile(
                          keyText: 'Deadline',
                          valueWidget: Text(
                            '${itemDetailPopupController.item.date!.year} 年 ${itemDetailPopupController.item.date!.month} 月 ${itemDetailPopupController.item.date!.day} 日',
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
                                      itemDetailPopupController
                                          .item.recurrence!],
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
                                          itemDetailPopupController
                                              .item.priority!],
                                      color: ItemConstant.priorityColorList[
                                          itemDetailPopupController
                                              .item.priority!],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(
                                        ItemConstant.priorityTextList[
                                            itemDetailPopupController
                                                .item.priority!],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: ItemConstant.priorityColorList[
                                              itemDetailPopupController
                                                  .item.priority!],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : DetailTile(
                      keyText: 'Difficulty',
                      valueWidget: Text(
                        ItemConstant.difficultyTextList[
                            itemDetailPopupController.item.difficulty!],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ItemConstant.difficultyColorList[
                              itemDetailPopupController.item.difficulty!],
                        ),
                      ),
                    ),
              if (itemDetailPopupController.item.note.isNotEmpty)
                DetailTile(
                  keyText: 'Note',
                  valueWidget: SingleChildScrollView(
                    child: SelectableText(
                      itemDetailPopupController.item.note,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: MyColors.text,
                      ),
                    ),
                  ),
                  isExpanded: true,
                ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyTextButton(
                    icon: Icons.delete,
                    text: 'Delete',
                    onPressed: () {
                      itemDetailPopupController.onItemDeleted();
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
