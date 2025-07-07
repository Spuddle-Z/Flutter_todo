import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:to_do/app/data/models/task_model.dart';

class MainController extends GetxController {
  // 状态变量
  final Rx<Box<Task>> taskBox = Hive.box<Task>('tasks').obs; // 任务盒
  final List<List<Rx<Box<bool>>>> hobbyBoxes = [
    [Hive.box<bool>('Rise').obs, Hive.box<bool>('Sleep').obs], // 早睡早起盒
    [Hive.box<bool>('Sports').obs], // 运动盒
    [Hive.box<bool>('Relax').obs], // 放松盒
  ];
  final Rx<DateTime> today = DateTime.now().obs; // 当前时间
  final RxInt currentIndex = 0.obs; // 当前页面索引

  // 焦点管理
  final FocusNode focusNode = FocusNode();

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
  void onReady() {
    super.onReady();
    Future.delayed(
        Duration.zero, () => focusNode.requestFocus()); // 等待组件渲染完成后请求焦点
  }

  @override
  void onClose() {
    focusNode.dispose(); // 释放焦点
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
        .where((k) =>
            taskBox.value.get(k)!.recurrence != null &&
            taskBox.value.get(k)!.recurrence! > 0)
        .toList();

    for (int i = 0; i < recurringKeys.length; i++) {
      Task recurringTask = taskBox.value.get(recurringKeys[i])!;
      // 循环生成下一个周期性任务，直到当前任务不需要再生成
      while (recurringTask.done ||
          recurringTask.date!.isBefore(DateTime.now()) ||
          recurringTask.date!.isAtSameMomentAs(DateTime.now())) {
        Task newTask = Task.copy(recurringTask);
        newTask.done = false;
        newTask.date =
            getNextDate(recurringTask.date!, recurringTask.recurrence!);
        taskBox.value.add(newTask);
        recurringTask.recurrence = 0; // 将原任务标记为不再周期性
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
  int sortItem(int keyA, int keyB) {
    Task taskA = taskBox.value.get(keyA)!;
    Task taskB = taskBox.value.get(keyB)!;

    // 未完成的任务排在前面
    if (taskA.done != taskB.done) {
      return taskA.done ? 1 : -1;
    }
    // 如果任务类型为任务，则按截止日期和优先级排序
    if (taskA.isTask && taskB.isTask) {
      // 按截止日期排序
      if (taskA.date! != taskB.date!) {
        return taskA.date!.compareTo(taskB.date!);
      }
      // 如果截止日期相同，按优先级排序
      return taskB.priority!.compareTo(taskA.priority!);
    }
    // 如果任务类型为杂事，则按难度排序
    return taskB.difficulty!.compareTo(taskA.difficulty!);
  }
}
