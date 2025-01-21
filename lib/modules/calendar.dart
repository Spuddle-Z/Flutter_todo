import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/task_model.dart';
import '../util/calendar_controller.dart';
import '../util/task_controller.dart';

import 'popup.dart';
import '../widget/recessed_panel.dart';
import '../widget/checkbox.dart';
import '../theme.dart';


class CalendarWidget extends StatelessWidget {
  CalendarWidget({super.key});

  final CalendarController calendarController = Get.find<CalendarController>();
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return RecessedPanel(
      child: Column(
        children: [
          CalendarHeader(calendarController: calendarController,),
          const WeekdayHeader(),
          AdaptiveGrid(
            calendarController: calendarController,
            taskController: taskController,
          ),
        ],
      ),
    );
  }
}

// 日历标题栏
class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    super.key,
    required this.calendarController,
  });

  final CalendarController calendarController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => calendarController.updateViewMonth(-1),
          icon: const Icon(Icons.keyboard_arrow_left),
          color: AppColors.text,
        ),
        Container(
          width: 200,
          alignment: Alignment.center,
          child: Obx(() => 
            Text(
              calendarController.viewMonthString.value,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () => calendarController.updateViewMonth(1),
          icon: const Icon(Icons.keyboard_arrow_right),
          color: AppColors.text,
        ),
      ],
    );
  }
}

// 星期标题栏
class WeekdayHeader extends StatelessWidget {
  const WeekdayHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
          double width = constraints.maxWidth / 7;
          double height = constraints.maxHeight;
      
          return GridView.builder(
            itemCount: 7,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: width / height,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: height,
                alignment: Alignment.center,
                child: Text(
                  days[index],
                  style: TextStyle(
                    color: index == 0 || index == 6 ? AppColors.textDark : AppColors.text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// 适应父组件大小的网格
class AdaptiveGrid extends StatelessWidget {
  const AdaptiveGrid({
    super.key,
    required this.calendarController,
    required this.taskController,
  });

  final CalendarController calendarController;
  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    const int rows = 6;
    const int columns = 7;

    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double cellWidth = constraints.maxWidth / columns;
          double cellHeight = constraints.maxHeight / rows;
      
          return GridView.builder(
            itemCount: rows * columns,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              childAspectRatio: cellWidth / cellHeight,
            ),
            itemBuilder: (BuildContext context, int index) {
              return DayCell(
                index: index,
                calendarController: calendarController,
                taskController: taskController,
              );
            },
          );
        },
      ),
    );
  }
}

// 日历单元格
class DayCell extends StatelessWidget {
  const DayCell({
    super.key,
    required this.index,
    required this.calendarController,
    required this.taskController,
  });

  final int index;
  final CalendarController calendarController;
  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Rx<DateTime> cellDate = calendarController.getCellDate(index).obs;
      final bool isToday = cellDate.value.day == calendarController.today.value.day &&
        cellDate.value.month == calendarController.today.value.month &&
        cellDate.value.year == calendarController.today.value.year;
      final bool isCurrentMonth = cellDate.value.month == calendarController.viewMonth.value.month;
      final bool isWeekend = cellDate.value.weekday == 7 || cellDate.value.weekday == 6;
      bool funcFilter(k) {
        bool taskDone = taskController.taskBox.value.get(k)!.taskDone;
        DateTime? taskDate = taskController.taskBox.value.get(k)!.taskDate;
        if (isToday) {
          return taskDate != null && (
            (!taskDone && taskDate.isBefore(cellDate.value)) ||
            taskDate.isAtSameMomentAs(cellDate.value));
        } else {
          return taskDate != null &&
            taskDate.isAtSameMomentAs(cellDate.value);
        }
      };

      return Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isCurrentMonth ? AppColors.background : AppColors.backgroundDark,
          border: Border.all(
            color: isToday ? AppColors.textDark : AppColors.backgroundDark,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Obx(() =>
              Text(
                '${cellDate.value.day}',
                style: TextStyle(
                  color: isToday ? AppColors.textActive : isWeekend ? AppColors.textDark : AppColors.text,
                ),
              ),
            ),
            Expanded(
              child: SmallTaskList(
                taskController: taskController,
                funcFilter: funcFilter,
                isToday: isToday,
              ),
            )
          ],
        ),
      );
    });
  }
}

// 日期单元格内的任务列表
class SmallTaskList extends StatelessWidget {
  const SmallTaskList({
    super.key,
    required this.taskController,
    required this.funcFilter,
    required this.isToday,
  });

  final TaskController taskController;
  final bool Function(dynamic) funcFilter;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final RxList<dynamic> keys = taskController.taskBox.value.keys.where(funcFilter).toList().obs;
      keys.sort((a, b) => taskController.sortTask(a, b));

      return ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(scrollbars: false),
        child: ListView.builder(
          itemCount: keys.length,
          itemBuilder: (context, index) {
            return SmallTaskTile(
              task: taskController.taskBox.value.get(keys[index])!,
              taskKey: keys[index],
              funcToggle: taskController.toggleTask,
              tileColor: taskController.getTaskColor(keys[index], isToday),
            );
          },
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
        ),
      );
    });
  }
}

// 任务单元
class SmallTaskTile extends StatelessWidget {
  final Task task;
  final int taskKey;
  final dynamic funcToggle;
  final Color tileColor;

  const SmallTaskTile({
    super.key, 
    required this.task,
    required this.taskKey,
    required this.funcToggle,
    required this.tileColor,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          color: tileColor.withAlpha(0x33),
          borderRadius: BorderRadius.circular(4),
          border: Border(
            top: BorderSide(color: tileColor, width: 2),
          ),
        ),
        child: Row(
          children: [
            // 勾选框
            CheckboxWidget(
              taskDone: task.taskDone, 
              tileColor: tileColor, 
              scale: 0.6,
              onChanged: (value) => funcToggle(taskKey),
            ),

            // 任务内容
            Expanded(
              child: Text(
                task.taskContent,
                style: TextStyle(
                  color: tileColor,
                  fontSize: 12,
                  decoration: task.taskDone ? TextDecoration.lineThrough : TextDecoration.none,
                  decorationColor: tileColor,
                  decorationThickness: 2,
                ),
              ),
            ),

            // 超时天数
            if (tileColor == AppColors.textActive)
              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: AppColors.textActive,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "${-task.taskDate!.difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays}天前",
                  style: TextStyle(
                    color: AppColors.background.withAlpha(0xaa),
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            // 更多按钮
            SizedBox(
              width: 18,
              height: 18,
              child: IconButton(
                icon: const Icon(Icons.more_vert),
                color: tileColor,
                iconSize: 12,
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Get.dialog(
                    InformationPopUp(
                      task: task,
                      realToggle: () => funcToggle(taskKey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
