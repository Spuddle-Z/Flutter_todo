import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/task_controller.dart';
import 'input_box.dart';
import '../theme.dart';

class AddTaskPopUp extends StatelessWidget {
  AddTaskPopUp({super.key});

  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'New Task',
        style: TextStyle(
          color: AppColors.primary,
        ),
      ),
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            CustomTextField(
              hintText: '又有嘛任务？',
              onChanged: (input) => taskController.newTask.value.taskContent = input,
              maxLines: 1,
            ),
            // Row(
            //   children: [
            //     Row(
            //       children: [
            //         CustomTextField(
            //           onChanged: (input) => taskController.year.value = int.parse(input),
            //           hintText: '',
            //         ),
            //         const Text(
            //           '年 ',
            //           style: TextStyle(
            //             color: AppColors.text,
            //           ),
            //         ),
            //         CustomTextField(
            //           onChanged: (input) => taskController.month.value = int.parse(input),
            //           hintText: '',
            //         ),
            //         const Text(
            //           '月 ',
            //           style: TextStyle(
            //             color: AppColors.text,
            //           ),
            //         ),
            //         CustomTextField(
            //           onChanged: (input) => taskController.day.value = int.parse(input),
            //           hintText: '',
            //         ),
            //         const Text(
            //           '日',
            //           style: TextStyle(
            //             color: AppColors.text,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            const Placeholder(
              fallbackHeight: 20,
            ),
            Expanded(
              child: CustomTextField(
                onChanged: (input) => taskController.newTask.value.taskNote = input,
                hintText: '备注',
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            taskController.clearNewTask();
            Get.back();
          },
          style: textButtonStyle(),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            taskController.addTask();
            Get.back();
          },
          style: textButtonStyle(),
          child: const Text('确定'),
        ),
      ],
    );
  }
}
