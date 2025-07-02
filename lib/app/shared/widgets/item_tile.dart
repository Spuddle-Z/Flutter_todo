import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';

import 'package:to_do/app/pages/todo/widgets/item_detail_popup.dart';
import 'package:to_do/app/pages/todo/widgets/item_popup.dart';

import 'package:to_do/app/data/models/task_model.dart';
import 'package:to_do/app/shared/constants/item_constant.dart';
import 'package:to_do/app/shared/widgets/my_checkbox.dart';
import 'package:to_do/app/shared/widgets/my_icon_button.dart';
import 'package:to_do/core/theme.dart';

class ItemTileController extends GetxController {
  ItemTileController({
    required this.itemKey,
    this.cellDate,
  });
  final int itemKey;
  final DateTime? cellDate;

  final MainController mainController = Get.find<MainController>();

  // 状态变量
  final RxBool isExpanded = false.obs; // 用于控制备注的展开状态

  // 计算变量
  Task get task => mainController.taskBox.value.get(itemKey)!; // 获取任务数据
  Color get color {
    // 根据任务状态和截止日期计算颜色
    if (task.done) {
      return MyColors.textDark;
    } else if (task.date != null &&
        task.date != cellDate &&
        task.date!.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return MyColors.textActive;
    } else {
      return ItemConstant.priorityColorList[task.priority];
    }
  }

  /// 切换任务完成状态
  void onTaskToggled(bool? done) {
    task.done = done!;
    mainController.updateTask(itemKey, task);
  }

  /// 删除任务
  void onTaskDelete() {
    mainController.deleteTask(itemKey);
  }
}

class ItemTile extends StatelessWidget {
  /// ### 任务组件
  ///
  /// 该组件用于在任务列表或日历中显示单个任务的简要内容。
  const ItemTile({
    super.key,
    required this.itemKey,
    required this.isMiniTile,
    this.cellDate,
  });
  final int itemKey;
  final bool isMiniTile;
  final DateTime? cellDate;

  @override
  Widget build(BuildContext context) {
    final ItemTileController itemTileController = Get.put(
        ItemTileController(itemKey: itemKey, cellDate: cellDate),
        tag: 'taskTileController_$itemKey _$isMiniTile ${cellDate ?? ''}');

    return Padding(
      padding: EdgeInsets.all(isMiniTile ? 2 : 4),
      child: Container(
        decoration: BoxDecoration(
          color: itemTileController.color.withAlpha(0x33),
          borderRadius: BorderRadius.circular(isMiniTile ? 4 : 8),
          border: Border(
            top: BorderSide(
              color: itemTileController.color,
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
                  done: itemTileController.task.done,
                  color: itemTileController.color,
                  activeColor: itemTileController.color,
                  scale: isMiniTile ? 0.6 : 1,
                  onChanged: itemTileController.onTaskToggled,
                ),

                // 任务内容
                Expanded(
                  child: Text(
                    itemTileController.task.content,
                    style: TextStyle(
                      color: itemTileController.color,
                      fontSize: isMiniTile ? 12 : 16,
                      decoration: itemTileController.task.done
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: itemTileController.color,
                      decorationThickness: 2,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),

                // 超时天数
                if (itemTileController.color == MyColors.textActive)
                  Container(
                    padding: EdgeInsets.all(isMiniTile ? 1 : 2),
                    decoration: BoxDecoration(
                      color: MyColors.textActive,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "${-itemTileController.task.date!.difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays}天前",
                      style: TextStyle(
                        color: MyColors.background.withAlpha(0xaa),
                        fontSize: isMiniTile ? 8 : 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                // 展开备注按钮
                if (!isMiniTile && itemTileController.task.note.isNotEmpty)
                  Obx(() {
                    return MyIconButton(
                      icon: AnimatedRotation(
                          duration: const Duration(milliseconds: 300),
                          turns: itemTileController.isExpanded.value ? 0.5 : 0,
                          child: const Icon(Icons.keyboard_arrow_down)),
                      color: itemTileController.color,
                      onPressed: () {
                        itemTileController.isExpanded.value =
                            !itemTileController.isExpanded.value;
                      },
                    );
                  }),

                // 编辑按钮
                if (!isMiniTile)
                  MyIconButton(
                    icon: const Icon(Icons.edit),
                    color: itemTileController.color,
                    onPressed: () => {
                      Get.dialog(
                        ItemPopup(itemKey: itemKey),
                        barrierDismissible: false,
                      )
                    },
                  ),

                // 删除按钮
                if (!isMiniTile)
                  MyIconButton(
                    icon: const Icon(Icons.close),
                    color: itemTileController.color,
                    onPressed: itemTileController.onTaskDelete,
                  ),

                // 更多按钮
                if (isMiniTile)
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: IconButton(
                      icon: const Icon(Icons.more_vert),
                      color: itemTileController.color,
                      iconSize: 12,
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        Get.dialog(
                          ItemDetailPopUp(itemKey: itemKey),
                        );
                      },
                    ),
                  ),
              ],
            ),

            // 备注内容
            if (!isMiniTile)
              Obx(() {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  height: itemTileController.isExpanded.value ? null : 0,
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: MyColors.backgroundDark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SelectableText(
                        itemTileController.task.note,
                        style: const TextStyle(
                          color: MyColors.text,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
