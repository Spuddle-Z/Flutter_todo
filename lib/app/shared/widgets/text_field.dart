import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/todo/controller/popup_controller.dart';
import 'package:to_do/core/theme.dart';



// 任务内容输入框
class ContentTextField extends StatelessWidget {
  ContentTextField({
    super.key,
    required this.popUpController,
  });

  final PopUpController popUpController;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textController.text = popUpController.newTask.value.taskContent;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Obx(
        () => TextField(
          // 样式设置
          cursorColor: AppColors.text,
          decoration: textFieldStyle(
            hintText: '又有嘛任务？',
            errorText: popUpController.contentError.value,
          ),

          // 功能设置
          controller: textController,
          onChanged: (input) {
            popUpController.newTask.value.taskContent = input;
            popUpController.checkContent();
          },
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
        ),
      ),
    );
  }
}

// 备注输入框
class NoteTextField extends StatelessWidget {
  NoteTextField({
    super.key,
    required this.popUpController,
  });

  final PopUpController popUpController;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textController.text = popUpController.newTask.value.taskNote;
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
        decoration: textFieldStyle(
          hintText: '备注：',
        ),

        // 功能设置
        controller: textController,
        onChanged: (input) => popUpController.newTask.value.taskNote = input,
      ),
    );
  }
}
