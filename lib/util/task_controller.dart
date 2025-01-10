import 'package:get/get.dart';
import 'package:hive/hive.dart';
// import 'package:time/time.dart';
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
  void addTask() {
    taskBox.add(Task.copy(newTask.value));
    clearNewTask();
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

  // 暂存输入内容
  var newTask = Task(
    taskContent: '',
    taskPriority: 0,
    taskNote: '',
  ).obs;
  var year = DateTime.now().year.obs;
  var month = DateTime.now().month.obs;
  var day = DateTime.now().day.obs;

  // 清空暂存内容
  void clearNewTask() {
    newTask.value.taskContent = 'BIG FUCKING GUN';
    newTask.value.taskPriority = 0;
    newTask.value.taskNote = '';
    year.value = DateTime.now().year;
    month.value = DateTime.now().month;
    day.value = DateTime.now().day;
  }
}
