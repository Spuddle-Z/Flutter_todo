import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/app/pages/todo/widgets/day_cell.dart';
import 'package:to_do/app/pages/todo/todo_controller.dart';
import 'package:to_do/app/pages/todo/controller/task_controller.dart';

import 'package:to_do/app/shared/widgets/button.dart';
import 'package:to_do/app/shared/widgets/recessed_panel.dart';
import 'package:to_do/core/theme.dart';

class CalendarWidget extends StatelessWidget {
  CalendarWidget({super.key});

  final TodoController todoController = Get.find<TodoController>();
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    const int rows = 6; // 一个月最多有6行
    const int columns = 7; // 一周7天

    return RecessedPanel(
      child: Column(
        children: [
          // 日历标题栏
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => todoController.updateViewMonth(-1),
                      icon: const Icon(Icons.keyboard_arrow_left),
                      color: AppColors.text,
                    ),
                    Container(
                      width: 200,
                      alignment: Alignment.center,
                      child: Obx(
                        () => Text(
                          todoController.viewMonthString.value,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => todoController.updateViewMonth(1),
                      icon: const Icon(Icons.keyboard_arrow_right),
                      color: AppColors.text,
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonsArea(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // 星期标题
          SizedBox(
            height: 40,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                List<String> days = const [
                  'Sun',
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat'
                ];
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
                          color: index == 0 || index == 6
                              ? AppColors.textDark
                              : AppColors.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // 日历网格
          Expanded(
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
                    return DayCell(index: index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
