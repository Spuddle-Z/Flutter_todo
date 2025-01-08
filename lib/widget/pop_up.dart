import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/task_controller.dart';
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
      content: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            InputBox(
              hintText: '又有嘛任务？',
              onChanged: (input) => taskController.newTask.value.taskContent = input,
              maxLines: 1,
            ),
            const Placeholder(
              fallbackHeight: 20,
            ),
            Expanded(
              child: InputBox(
                hintText: '备注',
                onChanged: (input) => taskController.newTask.value.taskNote = input,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
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

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.maxLines,
  });

  final Function(String) onChanged;
  final String hintText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        expands: maxLines == null,
        maxLines: maxLines,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          color: AppColors.text,
        ),
        cursorColor: AppColors.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.textDark,
          ),
          filled: true,
          fillColor: AppColors.backgroundDark,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.backgroundDark, 
              width: 2
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.primary, 
              width: 2
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.red,
              width: 2
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}