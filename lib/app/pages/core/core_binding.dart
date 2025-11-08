import 'package:get/get.dart';
import 'package:to_do/app/pages/core/core_controller.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CoreController());
  }
}


