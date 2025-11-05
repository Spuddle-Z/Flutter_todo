import 'dart:async';
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

  // 缓存的键列表
  final RxList<dynamic> _cachedKeys = <dynamic>[].obs;

  // 获取缓存好的、过滤后的键列表
  List<dynamic> get keys => _cachedKeys;

  // 更新键列表的防抖定时器
  Timer? _updateTimer;

  @override
  void onInit() {
    super.onInit();
    _updateKeys();
    // 监听 itemBox 变化，使用防抖批量更新缓存
    ever(mainController.itemBox, (_) => _scheduleUpdate());
  }

  @override
  void onClose() {
    _updateTimer?.cancel();
    super.onClose();
  }

  /// 防抖，避免频繁更新
  void _scheduleUpdate() {
    _updateTimer?.cancel();
    _updateTimer = Timer(const Duration(milliseconds: 100), () {
      _updateKeys();
    });
  }

  /// 更新键列表
  void _updateKeys() {
    List<dynamic> newKeys =
        mainController.itemBox.value.keys.where(filterItem).toList();
    newKeys.sort((a, b) => mainController.sortItem(a, b));
    _cachedKeys.value = newKeys;
  }
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
