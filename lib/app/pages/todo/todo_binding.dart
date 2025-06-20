import 'package:get/get.dart';
import 'package:to_do/app/pages/todo/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoController());
  }
}
