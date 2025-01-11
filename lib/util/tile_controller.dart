import 'package:get/get.dart';


class TileController extends GetxController {
  RxInt showTodayKey = (-1).obs;
  RxInt showNoDeadlineKey = (-1).obs;

  void todayToggleExpand(int key) {
    showTodayKey.value = showTodayKey.value == key ? -1 : key;
  }

  void noDeadlineToggleExpand(int key) {
    showNoDeadlineKey.value = showNoDeadlineKey.value == key ? -1 : key;
  }
}