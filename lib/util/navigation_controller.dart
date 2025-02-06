import 'package:get/get.dart';

import 'package:to_do/util/routes.dart';


class NavigationController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.offNamed(Routes.todo, id: 1);
        break;
      case 1:
        Get.offNamed(Routes.life, id: 1);
        break;
    }
  }
}