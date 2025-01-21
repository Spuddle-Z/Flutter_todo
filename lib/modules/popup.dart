import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../util/task_model.dart';
import '../util/task_controller.dart';
import '../util/popup_controller.dart';

import '../widget/checkbox.dart';
import '../theme.dart';


// ===== 添加任务弹出框 =====
class AddTaskPopup extends StatelessWidget {
  AddTaskPopup({super.key});

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
                  Expanded(
                    child: DateTextField(popUpController: popUpController),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RecurrenceField(popUpController: popUpController),
                  ),
                  const SizedBox(width: 8),
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
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (popUpController.checkContent() && popUpController.checkDate()) {
              taskController.addTask(popUpController.newTask.value);
              popUpController.clearNewTask();
              Get.back();
            }
          },
          style: textButtonStyle(),
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class EditTaskPopup extends StatelessWidget {
  EditTaskPopup({
    super.key,
    required this.taskKey
  });

  final int taskKey;
  final PopUpController popUpController = Get.put(PopUpController());
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    popUpController.loadTask(taskController.taskBox.value.get(taskKey)!);

    return AlertDialog(
      title: const Text(
        'Edit Task',
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
                  Expanded(
                    child: DateTextField(popUpController: popUpController),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RecurrenceField(popUpController: popUpController),
                  ),
                  const SizedBox(width: 8),
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
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (popUpController.checkContent() && popUpController.checkDate()) {
              taskController.updateTask(taskKey, popUpController.newTask.value);
              popUpController.clearNewTask();
              Get.back();
            }
          },
          style: textButtonStyle(),
          child: const Text('Edit'),
        ),
      ],
    );
  }
}

// 输入框样式
InputDecoration inputBoxStyle(String hintText, [String? errorText]) {
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
      errorText: errorText,
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
      child: Obx(() =>
        TextField(
          // 样式设置
          style: const TextStyle(
            color: AppColors.text,
          ),
          cursorColor: AppColors.text,
          decoration: inputBoxStyle(
            '又有嘛任务？',
            popUpController.contentError.value,
          ),

          // 功能设置
          controller: TextEditingController(text: popUpController.newTask.value.taskContent),
          onChanged: (input) {
            popUpController.newTask.value.taskContent = input;
            popUpController.checkContent();
          },
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
            popUpController.checkContent();
          },
        ),
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
        // 样式设置
        style: const TextStyle(
          color: AppColors.text,
        ),
        cursorColor: AppColors.text,
        decoration: inputBoxStyle(
          '截止日期',
          popUpController.dateError.value,
        ),
      
        // 功能设置
        controller: TextEditingController(text: popUpController.dateString.value),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(8),
        ],
        onChanged: (input) => popUpController.dateString.value = input,
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
          popUpController.checkDate();
        },
    );
  }
}

// 重复周期输入框
class RecurrenceField extends StatelessWidget {
  const RecurrenceField({
    super.key,
    required this.popUpController,
  });

  final PopUpController popUpController;

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      DropdownButtonFormField(
        // 样式设置
        hint: const Text(
          '请选择周期',
          style: TextStyle(
            color: AppColors.textDark,
          ),
        ),
        decoration: inputBoxStyle(''),
        dropdownColor: AppColors.backgroundDark,
        elevation: 16,

        // 功能设置
        value: popUpController.selectedRecurrence.value,
        onChanged: (value) {
          if (value != null) {
            popUpController.updateRecurrence(value);
          }
        },
        items: [
          for (int i = 0; i < popUpController.recurrenceList.length; i++)
            DropdownMenuItem(
              value: i,
              child: Text(
                popUpController.recurrenceList[i],
                style: const TextStyle(
                  color: AppColors.text,
                ),
              ),
            ),
        ],
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
        // 样式设置
        hint: const Text(
          '请选择优先级',
          style: TextStyle(
            color: AppColors.textDark,
          ),
        ),
        decoration: inputBoxStyle(''),
        dropdownColor: AppColors.backgroundDark,
        elevation: 16,
    
        // 功能设置
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
        // 样式设置
        expands: true,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          color: AppColors.text,
        ),
        cursorColor: AppColors.text,
        decoration: inputBoxStyle('备注：'),

        // 功能设置
        controller: TextEditingController(text: popUpController.newTask.value.taskNote),
        onChanged: (input) => popUpController.newTask.value.taskNote = input,
      ),
    );
  }
}


// ===== 任务详细信息弹出框 =====
class InformationPopUp extends StatelessWidget {
  const InformationPopUp({
    super.key,
    required this.task,
    required this.taskKey,
    required this.realToggle,
    required this.funcDelete,
  });

  final Task task;
  final int taskKey;
  final void Function() realToggle;
  final void Function() funcDelete;

  @override
  Widget build(BuildContext context) {
    List<String> priorityList = ['闲白儿', '正事儿', '急茬儿'];
    List<Color> priorityColors = [AppColors.green, AppColors.primary, AppColors.red];
    List<IconData> priorityIcons = [Icons.coffee, Icons.event_note, Icons.error_outline];
    RxBool fakeDone = task.taskDone.obs;

    return AlertDialog(
      title: Row(
        children: [
          Obx(() =>
            CheckboxWidget(
              taskDone: fakeDone.value,
              tileColor: AppColors.primary,
              scale: 1.2,
              onChanged: (value) {
                fakeDone.value = !fakeDone.value;
                realToggle();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              task.taskContent,
              style: const TextStyle(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          children: [
            ShowDeadline(task: task),
            Row(
              children: [
                Expanded(
                  child: ShowRecurrence(task: task),
                ),
                Expanded(
                  child: ShowPriority(
                    priorityColors: priorityColors,
                    task: task,
                    priorityIcons: priorityIcons,
                    priorityList: priorityList,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ShowNote(task: task),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            funcDelete();
            Get.back();
          },
          style: textButtonStyle(),
          child: const Text('Delete'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            Get.dialog(
              EditTaskPopup(taskKey: taskKey),
              barrierDismissible: false,
            );
          },
          style: textButtonStyle(),
          child: const Text('Edit'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          style: textButtonStyle(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

// 任务信息表头
class InformationHead extends StatelessWidget {
  const InformationHead({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      width: 100,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}

// 截止日期显示栏
class ShowDeadline extends StatelessWidget {
  const ShowDeadline({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const InformationHead(text: 'Deadline'),
        Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.backgroundDark,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '${task.taskDate!.year} 年 ${task.taskDate!.month} 月 ${task.taskDate!.day} 日',
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: AppColors.text,
            ),
          ),
        ),
      ],
    );
  }
}

// 优先级显示栏
class ShowPriority extends StatelessWidget {
  const ShowPriority({
    super.key,
    required this.priorityColors,
    required this.task,
    required this.priorityIcons,
    required this.priorityList,
  });

  final List<Color> priorityColors;
  final Task task;
  final List<IconData> priorityIcons;
  final List<String> priorityList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const InformationHead(text: 'Priority'),
        Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: priorityColors[task.taskPriority].withAlpha(0x33),
            borderRadius: BorderRadius.circular(8),
            border: Border(
              top: BorderSide(
                color: priorityColors[task.taskPriority],
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                priorityIcons[task.taskPriority],
                color: priorityColors[task.taskPriority],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  priorityList[task.taskPriority],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: priorityColors[task.taskPriority],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 周期性显示栏
class ShowRecurrence extends StatelessWidget {
  const ShowRecurrence({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const InformationHead(text: 'Recurrence'),
        Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.backgroundDark,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            task.taskRecurrence,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: AppColors.text,
            ),
          ),
        ),
      ],
    );
  }
}

// 备注显示栏
class ShowNote extends StatelessWidget {
  const ShowNote({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(8),
              width: 100,
              height: constraints.maxHeight,
              child: const Text(
                'Note',
                style: TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(8),
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  color: AppColors.backgroundDark,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    task.taskNote,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: AppColors.text,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
