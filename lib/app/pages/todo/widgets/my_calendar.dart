import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/app/pages/todo/widgets/calendar_day_cell.dart';
import 'package:to_do/app/pages/todo/todo_controller.dart';
import 'package:to_do/app/pages/todo/widgets/item_popup.dart';
import 'package:to_do/app/shared/constants/calendar_constant.dart';

import 'package:to_do/app/shared/widgets/my_text_button.dart';
import 'package:to_do/app/shared/widgets/recessed_panel.dart';
import 'package:to_do/core/theme.dart';

class MyCalendar extends StatelessWidget {
  /// ### 日历组件
  ///
  /// 该组件用于显示日历视图的任务清单。
  MyCalendar({super.key});

  final TodoController todoController = Get.find<TodoController>();

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
                      onPressed: () => todoController.viewMonth.value =
                          DateTime(todoController.viewMonth.value.year,
                              todoController.viewMonth.value.month - 1),
                      icon: const Icon(Icons.keyboard_arrow_left),
                      color: MyColors.text,
                    ),
                    Container(
                      width: 200,
                      alignment: Alignment.center,
                      child: Obx(() {
                        return Text(
                          todoController.viewMonthText,
                          style: const TextStyle(
                            color: MyColors.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                    ),
                    IconButton(
                      onPressed: () => todoController.viewMonth.value =
                          DateTime(todoController.viewMonth.value.year,
                              todoController.viewMonth.value.month + 1),
                      icon: const Icon(Icons.keyboard_arrow_right),
                      color: MyColors.text,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyTextButton(
                        icon: Icons.add,
                        text: 'Add Task',
                        onPressed: () {
                          Get.dialog(
                            const ItemPopup(),
                            barrierDismissible: false,
                          );
                        },
                        color: MyColors.text,
                      ),
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
                        CalendarConstant.weekdayAbbrList[index],
                        style: TextStyle(
                          color: index == 0 || index == 6
                              ? MyColors.textDark
                              : MyColors.text,
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
                    return CalendarDayCell(index: index);
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
