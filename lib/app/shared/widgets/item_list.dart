import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/app/pages/main/main_controller.dart';

import 'package:to_do/app/shared/widgets/item_tile.dart';

class ItemListController extends GetxController {
  ItemListController({
    required this.filterItem,
  });
  final bool Function(dynamic) filterItem;

  final MainController mainController = Get.find<MainController>();

  // 计算变量
  List<dynamic> get keys {
    List<dynamic> keys =
        mainController.itemBox.value.keys.where(filterItem).toList();
    keys.sort((a, b) => mainController.sortItem(a, b));
    return keys;
  } // 获取符合过滤条件的任务键列表
}

class ItemList extends StatelessWidget {
  /// ### 任务列表
  ///
  /// 该组件用于显示任务列表。
  const ItemList({
    super.key,
    required this.tag,
    required this.filterItem,
  });

  final String tag;
  final bool Function(dynamic) filterItem;

  @override
  Widget build(BuildContext context) {
    final ItemListController itemListController =
        Get.put(ItemListController(filterItem: filterItem), tag: tag);

    return Obx(() {
      return ListView.builder(
        itemCount: itemListController.keys.length,
        itemBuilder: (context, index) {
          return ItemTile(
            itemKey: itemListController.keys[index],
            isMiniTile: false,
          );
        },
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
      );
    });
  }
}
