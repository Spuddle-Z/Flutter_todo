import 'package:get/get.dart';
import 'package:hive/hive.dart';
// import 'package:time/time.dart';
import 'task_model.dart';

class TaskController extends GetxController {
  final Box<Task> taskBox = Hive.box<Task>('tasks');
  var tasks = <Task>[].obs;

  // 暂存输入内容
  var newTask = Task(
    taskContent: '',
    taskDone: false,
    taskPriority: 0
  ).obs;
  var year = DateTime.now().year.obs;
  var month = DateTime.now().month.obs;
  var day = DateTime.now().day.obs;

  // 初始化
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskBox.values.toList());
  }

  // 添加任务
  void addTask() {
    newTask.value.taskDue = DateTime(year.value, month.value, day.value);
    taskBox.add(newTask.value);
    tasks.add(newTask.value);
  }

  // 更新任务状态
  void toggleTask(int index) {
    final task = tasks[index];
    task.taskDone = !task.taskDone;
    taskBox.putAt(index, task);
    tasks[index] = task;
  }

  // 删除任务
  void deleteTask(int index) {
    taskBox.deleteAt(index);
    tasks.removeAt(index);
  }
}
