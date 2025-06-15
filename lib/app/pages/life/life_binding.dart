import 'package:get/get.dart';
import 'package:to_do/app/pages/life/controller/hobbies_controller.dart';
import 'package:to_do/app/pages/life/controller/hot_map_controller.dart';

class LifeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HobbiesController());
    Get.lazyPut(() => HotMapController());
  }
}
