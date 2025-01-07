import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'task_model.dart';

class TaskController extends GetxController {
  final Box<Task> taskBox = Hive.box<Task>('tasks');
  var tasks = <Task>[].obs;

  // 初始化
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskBox.values.toList());
  }

  // 添加任务
  void addTask(String task_content, bool task_done, int task_priority) {
    final task = Task(
      task_content: task_content,
      task_done: task_done,
      task_priority: task_priority,
    );
    taskBox.add(task);
    tasks.add(task);
  }

  // 更新任务状态
  void toggleTask(int index) {
    final task = tasks[index];
    task.task_done = !task.task_done;
    taskBox.putAt(index, task);
    tasks[index] = task;
  }

  // 删除任务
  void deleteTask(int index) {
    taskBox.deleteAt(index);
    tasks.removeAt(index);
  }
}
