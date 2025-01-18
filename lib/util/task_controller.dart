import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'task_model.dart';

class TaskController extends GetxController {
  Rx<Box<Task>> taskBox = Hive.box<Task>('tasks').obs;

  @override
  void onInit() {
    super.onInit();
    generateTask();
  }

  void generateTask() {
    // 计算周期性任务的下个截止日期
    DateTime getNextDate(DateTime date, String recurrence) {
      if (recurrence == '每天') {
        return date.add(const Duration(days: 1));
      } else if (recurrence == '每周') {
        return date.add(const Duration(days: 7));
      } else if (recurrence == '每月') {
        return DateTime(date.year, date.month + 1, date.day);
      } else {
        return DateTime(date.year + 1, date.month, date.day);
      }
    }
    
    // 判断是否生成新任务
    bool ifGenerate(bool done, DateTime date) {
      return done || date.isBefore(DateTime.now()) || date.isAtSameMomentAs(DateTime.now());
    }

    List<dynamic> keys = taskBox.value.keys.where((k) => taskBox.value.get(k)!.taskRecurrence != '不重复').toList();
    for (int i = 0; i < keys.length; i++) {
      Task task = taskBox.value.get(keys[i])!;
      while (ifGenerate(task.taskDone, task.taskDate!)) {
        Task newTask = Task.copy(task);
        newTask.taskRecurrence = '不重复';
        taskBox.value.add(newTask);
        task.taskDate = getNextDate(task.taskDate!, task.taskRecurrence);
      }
    }
  }

  // 添加任务
  void addTask(Task newTask) {
    taskBox.value.add(Task.copy(newTask));
    generateTask();
    taskBox.refresh();
  }

  // 更新任务状态
  void toggleTask(int key) {
    final task = taskBox.value.get(key);
    task!.taskDone = !task.taskDone;
    taskBox.value.put(key, task);
    generateTask();
    taskBox.refresh();
  }

  // 删除任务
  void deleteTask(int key) {
    taskBox.value.delete(key);
    taskBox.refresh();
  }
}
