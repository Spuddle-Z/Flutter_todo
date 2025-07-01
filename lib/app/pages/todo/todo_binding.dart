import 'package:get/get.dart';
import 'package:to_do/app/pages/todo/todo_controller.dart';
import 'package:to_do/app/pages/todo/widgets/random_task.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoController()); // To Do 页面的总控制器
    Get.lazyPut(() => RandomTaskController()); // 随机任务控制器详情弹窗控制器
  }
}
