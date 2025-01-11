import 'package:get/get.dart';


class TileController extends GetxController {
  RxInt showTodayKey = (-1).obs;
  RxInt showNoDeadlineKey = (-1).obs;

  void todayExpand(int key) {
    showTodayKey.value = key;
  }

  void todayHind() {
    showTodayKey.value = -1;
  }

  void noDeadlineExpand(int key) {
    showNoDeadlineKey.value = key;
  }

  void noDeadlineHind() {
    showNoDeadlineKey.value = -1;
  }
}