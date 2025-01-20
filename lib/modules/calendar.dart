import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/task_model.dart';
import '../util/calendar_controller.dart';
import '../util/task_controller.dart';

import '../modules/pop_up.dart';
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
          onPressed: () => {},
          icon: const Icon(Icons.keyboard_arrow_left),
          color: AppColors.text,
        ),
        Obx(() => 
          Text(
            calendarController.viewMonthString.value,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () => {},
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
    DateTime date = calendarController.getCellDate(index);
    final bool isToday = date.day == calendarController.today.value.day &&
      date.month == calendarController.today.value.month &&
      date.year == calendarController.today.value.year;
    final bool isCurrentMonth = date.month == calendarController.viewMonth.value.month;
    final bool isWeekend = date.weekday == 7 || date.weekday == 6;

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
          Text(
            '${date.day}',
            style: TextStyle(
              color: isToday ? AppColors.textActive : isWeekend ? AppColors.textDark : AppColors.text,
            ),
          ),
          Expanded(
            child: SmallTaskList(
              taskController: taskController,
              funcFilter: (k) {
                DateTime? taskDate = taskController.taskBox.value.get(k)!.taskDate;
                return taskDate != null &&
                  taskDate.year == date.year &&
                  taskDate.month == date.month &&
                  taskDate.day == date.day;
              },
            ),
          )
        ],
      ),
    );
  }
}

// 日期单元格内的任务列表
class SmallTaskList extends StatelessWidget {
  const SmallTaskList({
    super.key,
    required this.taskController,
    required this.funcFilter,
  });

  final TaskController taskController;
  final bool Function(dynamic) funcFilter;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final RxList<dynamic> keys = taskController.taskBox.value.keys.where(funcFilter).toList().obs;
      keys.sort((a, b) => taskController.sortTask(a, b));

      return ListView.builder(
        itemCount: keys.length,
        itemBuilder: (context, index) {
          return SmallTaskTile(
            task: taskController.taskBox.value.get(keys[index])!,
            taskKey: keys[index],
            funcToggle: taskController.toggleTask,
          );
        },
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
      );
    });
  }
}

// 任务单元
class SmallTaskTile extends StatelessWidget {
  final Task task;
  final int taskKey;
  final dynamic funcToggle;

  const SmallTaskTile({
    super.key, 
    required this.task,
    required this.taskKey,
    required this.funcToggle,
  });

  @override
  Widget build(BuildContext context) {
    Color tileColor;
    switch (task.taskPriority) {
      case 0:
        tileColor = AppColors.green;
        break;
      case 1:
        tileColor = AppColors.primary;
        break;
      case 2:
        tileColor = AppColors.red;
        break;
      default:
        tileColor = AppColors.textActive;
    }

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
