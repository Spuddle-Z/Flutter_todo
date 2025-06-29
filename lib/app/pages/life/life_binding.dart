import 'package:get/get.dart';
import 'package:to_do/app/pages/life/life_controller.dart';

class LifeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LifeController());
  }
}
