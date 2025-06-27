import 'dart:async';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:to_do/app/data/models/task_model.dart';

class MainController extends GetxController {
  // 状态变量
  final Rx<Box<Task>> taskBox = Hive.box<Task>('tasks').obs; // 任务盒
  final Rx<DateTime> today = DateTime.now().obs; // 当前时间
  final RxInt currentIndex = 0.obs; // 当前页面索引

  // 定时器，用于每分钟更新当前时间
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    // 每分钟更新一次当前时间
    timer = Timer.periodic(const Duration(minutes: 1), (_) {
      today.value = DateTime.now();
    });

    // 自动生成周期性任务
    generateTask();
  }

  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
  }

  /// 添加任务
  void addTask(Task task) {
    taskBox.value.add(task);
    generateTask();
    taskBox.refresh();
  }

  /// 更新任务
  void updateTask(int key, Task task) {
    taskBox.value.put(key, task);
    generateTask();
    taskBox.refresh();
  }

  /// 删除任务
  void deleteTask(int key) {
    taskBox.value.delete(key);
    taskBox.refresh();
  }

  /// 计算周期性任务的下个截止日期
  DateTime getNextDate(DateTime date, int recurrence) {
    if (recurrence == 1) {
      return date.add(const Duration(days: 1));
    } else if (recurrence == 2) {
      return date.add(const Duration(days: 7));
    } else if (recurrence == 3) {
      return DateTime(date.year, date.month + 1, date.day);
    } else {
      return DateTime(date.year + 1, date.month, date.day);
    }
  }

  /// 自动生成周期性任务。
  void generateTask() {
    // 筛选出周期性任务的键
    List<dynamic> recurringKeys = taskBox.value.keys
        .where((k) => taskBox.value.get(k)!.taskRecurrence != 0)
        .toList();

    for (int i = 0; i < recurringKeys.length; i++) {
      Task recurringTask = taskBox.value.get(recurringKeys[i])!;
      // 循环生成下一个周期性任务，直到当前任务不需要再生成
      while (recurringTask.taskDone ||
          recurringTask.taskDate!.isBefore(DateTime.now()) ||
          recurringTask.taskDate!.isAtSameMomentAs(DateTime.now())) {
        Task newTask = Task.copy(recurringTask);
        newTask.taskDone = false;
        newTask.taskDate =
            getNextDate(recurringTask.taskDate!, recurringTask.taskRecurrence);
        taskBox.value.add(newTask);
        recurringTask.taskRecurrence = 0; // 将原任务标记为不再周期性
        taskBox.value.put(recurringKeys[i], recurringTask);
        recurringTask = newTask;
      }
    }
  }

  /// 任务排序函数
  ///
  /// 输入参数：
  /// - `keyA` 第一个任务的键
  /// - `keyB` 第二个任务的键
  ///
  /// 返回值：
  /// - 返回值为1时，表示`keyA`在`keyB`之后；返回值为-1时，表示`keyA`在`keyB`之前；返回值为0时，表示两者相等。
  int sortTask(int keyA, int keyB) {
    Task taskA = taskBox.value.get(keyA)!;
    Task taskB = taskBox.value.get(keyB)!;

    // 未完成的任务排在前面
    if (taskA.taskDone != taskB.taskDone) {
      return taskA.taskDone ? 1 : -1;
    }
    // 按截止日期排序
    if (taskA.taskDate != null &&
        taskB.taskDate != null &&
        taskA.taskDate != taskB.taskDate) {
      return taskA.taskDate!.compareTo(taskB.taskDate!);
    }
    // 按优先级排序
    return taskB.taskPriority.compareTo(taskA.taskPriority);
  }
}
