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
    taskRecurrence: '不重复',
  ).obs;

  // 清空暂存内容
  void clearNewTask() {
    newTask.value.taskContent = 'BIG FUCKING GUN';
    newTask.value.taskPriority = 0;
    newTask.value.taskNote = '';
    newTask.value.taskRecurrence = '不重复';

    dateString.value = 
      '${DateTime.now().year}'
      '${DateTime.now().month.toString().padLeft(2, '0')}'
      '${DateTime.now().day.toString().padLeft(2, '0')}';
    selectedPriority.value = 0;
    selectedRecurrence.value = null;

    contentError.value = null;
    dateError.value = null;
  }

  // 管理日期输入
  RxString dateString = RxString(
    '${DateTime.now().year}'
    '${DateTime.now().month.toString().padLeft(2, '0')}'
    '${DateTime.now().day.toString().padLeft(2, '0')}'
  );

  // 管理周期输入
  List<String> recurrenceList = ['不重复', '每天', '每周', '每月'];
  RxnInt selectedRecurrence = RxnInt(0);
  void updateRecurrence(int recurrence) {
    selectedRecurrence.value = recurrence;
    newTask.value.taskRecurrence = recurrenceList[recurrence];
  }

  // 管理优先级选择器
  List<String> priorityList = ['闲白儿', '正事儿', '急茬儿'];
  List<Color> priorityColors = [AppColors.green, AppColors.primary, AppColors.red];
  List<IconData> priorityIcons = [Icons.coffee, Icons.event_note, Icons.error_outline];
  RxnInt selectedPriority = RxnInt(0);
  void updatePriority(int priority) {
    selectedPriority.value = priority;
    newTask.value.taskPriority = priority;
  }

  // 检查任务内容
  RxnString contentError = RxnString();
  bool checkContent() {
    if (newTask.value.taskContent.isEmpty) {
      contentError.value = '任务内容不能为空';
      return false;
    } else {
      contentError.value = null;
      return true;
    }
  }

  // 检查日期
  RxnString dateError = RxnString();
  bool checkDate() {
    if (dateString.value.length != 8) {
      dateError.value = '请按照 YYYYMMDD 的格式输入日期';
      return false;
    } else {
      try {
        DateTime.parse(
          '${dateString.value.substring(0, 4)}-'
          '${dateString.value.substring(4, 6)}-'
          '${dateString.value.substring(6, 8)}'
        );
        dateError.value = null;
        return true;
      } catch (e) {
        dateError.value = '请输入有效日期';
        return false;
      }
    }
  }
}
