import 'package:get/get.dart';
import 'package:to_do/pages/life/controller/hobbies_controller.dart';
import 'package:to_do/pages/todo/controller/calendar_controller.dart';
import 'package:to_do/pages/todo/controller/task_controller.dart';


class TodoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalendarController());
    Get.lazyPut(() => TaskController());
  }
}

class LifeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HobbiesController());
  }
}
