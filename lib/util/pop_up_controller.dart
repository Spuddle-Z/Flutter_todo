import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_model.dart';
import '../theme.dart';

class PopUpController extends GetxController {
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
    selectedPriority.value = null;
  }

  // 管理优先级选择器
  List<String> priorityList = ['闲白儿', '正事儿', '急茬儿'];
  List<Color> priorityColors = [AppColors.green, AppColors.primary, AppColors.red];
  List<IconData> priorityIcons = [Icons.coffee, Icons.event_note, Icons.error_outline];
  RxnInt selectedPriority = RxnInt();
  void updatePriority(int priority) {
    selectedPriority.value = priority;
    newTask.value.taskPriority = priority;
  }
}
