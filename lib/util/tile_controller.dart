import 'package:get/get.dart';


class TileController extends GetxController {
  RxString? showTodayId;
  RxString? showNoDeadlineId;

  void showToday(String id) {
    showTodayId?.value = id;
  }

  void hideToday() {
    showTodayId = null;
  }

  void showNoDeadline(String id) {
    showNoDeadlineId?.value = id;
  }

  void hideNoDeadline() {
    showNoDeadlineId = null;
  }
}