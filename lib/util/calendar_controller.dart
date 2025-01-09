import 'dart:async';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  var today = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    // 启动定时器，每分钟更新一次 today's 日期
    timer = Timer.periodic(const Duration(minutes: 1), (_) {
      today.value = DateTime.now();
    });
  }
  
  @override
  void onClose() {
    super.onClose();
    // 在控制器销毁时取消定时器
    timer?.cancel();
  }

  // 更新选中的日期
  void updateSelectedDay(DateTime date) {
    selectedDay.value = date;
  }
}
