import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'task_model.dart';

class TaskController extends GetxController {
  Rx<Box<Task>> taskBox = Hive.box<Task>('tasks').obs;

  // 添加任务
  void addTask(Task newTask) {
    taskBox.value.add(Task.copy(newTask));
    taskBox.refresh();
  }

  // 更新任务状态
  void toggleTask(int key) {
    final task = taskBox.value.get(key);
    task!.taskDone = !task.taskDone;
    taskBox.value.put(key, task);
    taskBox.refresh();
  }

  // 删除任务
  void deleteTask(int key) {
    taskBox.value.delete(key);
    taskBox.refresh();
  }
}
