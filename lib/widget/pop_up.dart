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
            ContentTextField(
              popUpController: popUpController,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  // Expanded(
                  //   child: DateTextField(popUpController: popUpController),
                  // ),
                  const Expanded(
                    child: Placeholder(fallbackHeight: 20,),
                  ),
                  Expanded(
                    child: PriorityPopUp(popUpController: popUpController),
                  ),
                ],
              ),
            ),
            Expanded(
              child: NoteTextField(
                popUpController: popUpController,
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


// 输入框样式
InputDecoration inputBoxStyle(String hintText) {
  return InputDecoration(
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
    );
}

// 任务内容输入框
class ContentTextField extends StatelessWidget {
  const ContentTextField({
    super.key,
    required this.popUpController,
  });

  final PopUpController popUpController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        style: const TextStyle(
          color: AppColors.text,
        ),
        cursorColor: AppColors.text,
        decoration: inputBoxStyle('又有嘛任务？'),
        onChanged: (input) => popUpController.newTask.value.taskContent = input,
      ),
    );
  }
}

// 截止日期输入框
class DateTextField extends StatelessWidget {
  const DateTextField({
    super.key,
    required this.popUpController,
  });

  final PopUpController popUpController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: inputBoxStyle('截止日期'),
      keyboardType: TextInputType.datetime,
      onChanged: (input) => popUpController.date.value = input,
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
        hint: const Text(
          '请选择优先级',
          style: TextStyle(
            color: AppColors.textDark,
          ),
        ),
        decoration: inputBoxStyle(''),
        dropdownColor: AppColors.backgroundDark,
        elevation: 16,
    
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

// 备注输入框
class NoteTextField extends StatelessWidget {
  const NoteTextField({
    super.key,
    required this.popUpController,
  });

  final PopUpController popUpController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        expands: true,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          color: AppColors.text,
        ),
        cursorColor: AppColors.text,
        decoration: inputBoxStyle('备注：'),
        onChanged: (input) => popUpController.newTask.value.taskNote = input,
      ),
    );
  }
}
