import 'package:get/get.dart';

class MainController extends GetxController {
  // 当前页面索引
  final currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}
