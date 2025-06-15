import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/todo/widgets/small_task_tile.dart';
import 'package:to_do/app/pages/todo/todo_controller.dart';
import 'package:to_do/app/pages/todo/controller/task_controller.dart';
import 'package:to_do/core/theme.dart';

// 日历单元格控制器
class DayCellController extends GetxController {
  DayCellController({
    required this.index,
  });
  final TodoController calendarController = Get.find<TodoController>();
  final TaskController taskController = Get.find<TaskController>();
  final int index;

  late Rx<DateTime> cellDate;
  late bool isToday;
  late bool isCurrentMonth;
  late bool isWeekend;
  late RxList<dynamic> keys;

  @override
  void onInit() {
    super.onInit();
    cellDate = calendarController.getCellDate(index).obs;
    isToday = cellDate.value.day == calendarController.today.value.day &&
        cellDate.value.month == calendarController.today.value.month &&
        cellDate.value.year == calendarController.today.value.year;
    isCurrentMonth =
        cellDate.value.month == calendarController.viewMonth.value.month;
    isWeekend = cellDate.value.weekday == 7 || cellDate.value.weekday == 6;
    keys = taskController.taskBox.value.keys.where(ifShow).toList().obs;
    keys.sort((a, b) => taskController.sortTask(a, b));
  }

  // 过滤函数，判断任务是否要显示在当前单元格内
  bool ifShow(key) {
    bool taskDone = taskController.taskBox.value.get(key)!.taskDone;
    DateTime? taskDate = taskController.taskBox.value.get(key)!.taskDate;
    if (isToday) {
      return taskDate != null &&
          ((!taskDone && taskDate.isBefore(cellDate.value)) ||
              taskDate.isAtSameMomentAs(cellDate.value));
    } else {
      return taskDate != null && taskDate.isAtSameMomentAs(cellDate.value);
    }
  }

  Widget getSmallTaskTile(int index) {
    return SmallTaskTile(
      task: taskController.taskBox.value.get(keys[index])!,
      taskKey: keys[index],
      funcToggle: taskController.toggleTask,
      funcDelete: taskController.deleteTask,
      tileColor: taskController.getTaskColor(keys[index], isToday),
    );
  }
}

// 日历单元格
class DayCell extends StatelessWidget {
  DayCell({
    super.key,
    required this.index,
  });

  final int index;
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    final DayCellController dayCellController = Get.put(
        DayCellController(index: index),
        tag: 'dayCellController_$index');
    return Obx(() {
      return Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: dayCellController.isCurrentMonth
              ? AppColors.background
              : AppColors.backgroundDark,
          border: Border.all(
            color: dayCellController.isToday
                ? AppColors.textDark
                : AppColors.backgroundDark,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              '${dayCellController.cellDate.value.day}',
              style: TextStyle(
                color: dayCellController.isToday
                    ? AppColors.textActive
                    : dayCellController.isWeekend
                        ? AppColors.textDark
                        : AppColors.text,
              ),
            ),
            // 任务列表
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    const MaterialScrollBehavior().copyWith(scrollbars: false),
                child: ListView.builder(
                  itemCount: dayCellController.keys.length,
                  itemBuilder: (context, index) {
                    return SmallTaskTile(
                      task: taskController.taskBox.value
                          .get(dayCellController.keys[index])!,
                      taskKey: dayCellController.keys[index],
                      funcToggle: taskController.toggleTask,
                      funcDelete: taskController.deleteTask,
                      tileColor: taskController.getTaskColor(
                          dayCellController.keys[index],
                          dayCellController.isToday),
                    );
                  },
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
