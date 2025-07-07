import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';

class LifeController extends GetxController {
  final MainController mainController = Get.find<MainController>();

  // 状态变量
  final RxInt viewYear = DateTime.now().year.obs; // 当前显示的年份

  // 计算变量
  int get firstDayIndex =>
      DateTime(viewYear.value, 1, 1).weekday % 7; // 当前显示年份的第一天在一周中的索引
  String get viewYearString => '${viewYear.value}';

  /// 过滤杂事
  bool filterTrivia(key) {
    return !mainController.taskBox.value.get(key)!.isTask;
  }
}
