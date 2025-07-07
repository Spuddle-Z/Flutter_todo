import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/todo/todo_controller.dart';
import 'package:to_do/app/pages/todo/widgets/my_calendar.dart';
import 'package:to_do/app/pages/todo/widgets/hobby_list.dart';
import 'package:to_do/app/shared/widgets/item_list.dart';
import 'package:to_do/app/shared/widgets/recessed_panel.dart';
import 'package:to_do/core/theme.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final todoController = Get.find<TodoController>();

    return Container(
      color: MyColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: MyCalendar(),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: RecessedPanel(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Today',
                            style: TextStyle(
                              color: MyColors.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ItemList(
                            tag: 'today',
                            filterItem: todoController.filterTodayTask,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 习惯列表
                Expanded(
                  flex: 3,
                  child: RecessedPanel(
                    child: const Row(
                      children: [
                        Expanded(
                          child: HobbyList(isToday: false),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: HobbyList(isToday: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
