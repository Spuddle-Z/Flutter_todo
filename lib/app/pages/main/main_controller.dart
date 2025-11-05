import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:to_do/app/data/models/item_model.dart';

class MainController extends GetxController {
  // 状态变量
  final Rx<Box<Item>> itemBox = Hive.box<Item>('Items').obs; // 任务盒
  final List<List<Rx<Box<bool>>>> hobbyBoxes = [
    [Hive.box<bool>('Rise').obs, Hive.box<bool>('Sleep').obs], // 早睡早起盒
    [Hive.box<bool>('Sports').obs], // 运动盒
    [Hive.box<bool>('Relax').obs], // 放松盒
  ];
  final Rx<DateTime> today = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).obs; // 当前时间
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
      today.value = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
    });

    // 自动生成周期性任务（异步执行，不阻塞初始化）
    Future.microtask(() => generateRecurringTask());
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
  void addItem(Item item) {
    itemBox.value.add(item);
    generateRecurringTask();
    itemBox.refresh();
  }

  /// 更新任务
  void updateItem(int key, Item item) {
    itemBox.value.put(key, item);
    generateRecurringTask();
    Future.microtask(() => itemBox.refresh());  // 异步触发刷新，避免阻塞UI
  }

  /// 删除任务
  void deleteItem(int key) {
    itemBox.value.delete(key);
    itemBox.refresh();
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
  Future<void> generateRecurringTask() async {
    // 筛选出周期性任务的键
    List<dynamic> recurringKeys = itemBox.value.keys
        .where((k) =>
            itemBox.value.get(k)!.recurrence != null &&
            itemBox.value.get(k)!.recurrence! > 0)
        .toList();

    for (int i = 0; i < recurringKeys.length; i++) {
      int recurringKey = recurringKeys[i];
      Item recurringTask = itemBox.value.get(recurringKey)!;
      // 循环生成下一个周期性任务，直到当前任务不需要再生成
      while (recurringTask.done ||
          recurringTask.date!
              .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
        Item newTask = Item.copy(recurringTask);
        recurringTask.recurrence = 0; // 将原任务标记为不再周期性
        itemBox.value.put(recurringKey, recurringTask);

        // 调整新任务的属性并存入
        newTask.done = false;
        newTask.date = getNextDate(newTask.date!, newTask.recurrence!);
        recurringKey = await itemBox.value.add(newTask);
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
    Item taskA = itemBox.value.get(keyA)!;
    Item taskB = itemBox.value.get(keyB)!;

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
