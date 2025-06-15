import 'package:get/get.dart';
import 'package:to_do/app/pages/life/life_binding.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/pages/todo/todo_binding.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());

    // 注册子页面的依赖
    TodoBinding().dependencies();
    LifeBinding().dependencies();
  }
}
