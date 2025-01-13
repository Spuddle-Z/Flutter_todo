import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'task_model.dart';

class TaskController extends GetxController {
  final Box<Task> taskBox = Hive.box<Task>('tasks');
  var keyList = [].obs;
  var testKeys = [].obs;

  // 初始化
  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  // 筛选任务
  void loadTasks() {
    keyList.assignAll(taskBox.keys.toList());
    testKeys.assignAll(keyList.where((k) => taskBox.get(k)!.taskContent == 'test').toList());
  }

  // 添加任务
  void addTask(Task newTask) {
    taskBox.add(Task.copy(newTask));
    loadTasks();
  }

  // 更新任务状态
  void toggleTask(int key) {
    final task = taskBox.get(key);
    task!.taskDone = !task.taskDone;
    taskBox.put(key, task);
    loadTasks();
  }

  // 删除任务
  void deleteTask(int key) {
    taskBox.delete(key);
    loadTasks();
  }
}
