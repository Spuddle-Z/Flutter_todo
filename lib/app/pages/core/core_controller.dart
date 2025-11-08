import 'dart:async';
import 'package:get/get.dart';
import 'package:to_do/app/data/models/item_model.dart';
import 'package:to_do/app/pages/main/main_controller.dart';

class CoreController extends GetxController {
  final MainController mainController = Get.find<MainController>();

  final RxList<int> _keys = <int>[].obs;
  List<int> get keys => _keys;

  Timer? _updateTimer;

  @override
  void onInit() {
    super.onInit();
    _update();
    ever(mainController.itemBox, (_) => _scheduleUpdate());
    ever(mainController.today, (_) => _scheduleUpdate());
  }

  @override
  void onClose() {
    _updateTimer?.cancel();
    super.onClose();
  }

  void _scheduleUpdate() {
    _updateTimer?.cancel();
    _updateTimer = Timer(const Duration(milliseconds: 100), _update);
  }

  void _update() {
    final box = mainController.itemBox.value;
    final List<int> allKeys = box.keys
        .whereType<int>()
        .where((k) {
          final item = box.get(k);
          return item != null && item.isTask; // 仅任务
        })
        .toList();

    allKeys.sort((a, b) {
      final ai = box.get(a) as Item;
      final bi = box.get(b) as Item;
      final ad = ai.date;
      final bd = bi.date;
      if (ad == null && bd == null) return 0;
      if (ad == null) return 1; // 无日期的排后
      if (bd == null) return -1;
      return ad.compareTo(bd); // 按时间正序
    });

    _keys.value = allKeys;
  }
}


