import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../util/task_controller.dart';
import '../util/pop_up_controller.dart';
import '../theme.dart';

class AddTaskPopUp extends StatelessWidget {
  AddTaskPopUp({super.key});

  final PopUpController popUpController = Get.put(PopUpController());
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
              onChanged: (input) => popUpController.newTask.value.taskContent = input,
              maxLines: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Placeholder(
                    fallbackHeight: 20,
                  ),
                  Expanded(
                    child: PriorityPopUp(popUpController: popUpController),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CustomTextField(
                onChanged: (input) => popUpController.newTask.value.taskNote = input,
                hintText: '备注',
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            popUpController.clearNewTask();
            Get.back();
          },
          style: textButtonStyle(),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            taskController.addTask(popUpController.newTask.value);
            popUpController.clearNewTask();
            Get.back();
          },
          style: textButtonStyle(),
          child: const Text('确定'),
        ),
      ],
    );
  }
}

// 输入框
class CustomTextField extends StatelessWidget {
  const CustomTextField({
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

// 优先级下拉栏
class PriorityPopUp extends StatelessWidget {
  const PriorityPopUp({
    super.key,
    required this.popUpController,
  });

  final PopUpController popUpController;

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      DropdownButtonFormField(
        // 选择框样式
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.backgroundDark,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.backgroundDark,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
        ),
        hint: const Text(
          '请选择优先级',
          style: TextStyle(
            color: AppColors.textDark,
          ),
        ),
        dropdownColor: AppColors.backgroundDark,
        elevation: 16,
        isDense: true,
    
        // 选择框功能设置
        value: popUpController.selectedPriority.value,
        onChanged: (value) {
          if (value != null) {
            popUpController.updatePriority(value);
          }
        },
        items: [
          for (int i = 0; i < popUpController.priorityList.length; i++)
            DropdownMenuItem(
              value: i,
              child: Row(
                children: [
                  Icon(
                    popUpController.priorityIcons[i],
                    color: popUpController.priorityColors[i],
                  ),
                  Text(
                    popUpController.priorityList[i],
                    style: TextStyle(
                      color: popUpController.priorityColors[i],
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