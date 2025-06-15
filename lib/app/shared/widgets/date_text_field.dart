import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/app/pages/todo/controller/popup_controller.dart';
import 'package:to_do/core/theme.dart';

/*
  日期输入框
  该输入框用于输入日期，输入格式为8位数字，表示年月日（YYYYMMDD）。
  如果输入不符合要求，将显示错误提示。
*/
class DateTextField extends StatelessWidget {
  DateTextField({
    super.key,
    required this.popUpController,
  });

  final PopUpController popUpController;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textController.text = popUpController.dateString.value;
    return TextField(
      // 样式设置
      style: const TextStyle(
        color: AppColors.text,
      ),
      cursorColor: AppColors.text,
      decoration: textFieldStyle(
        '无截止日期',
        popUpController.dateError.value,
      ),

      // 功能设置
      controller: textController,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(8),
      ],
      onChanged: (input) {
        popUpController.dateString.value = input;
        popUpController.checkDate();
      },
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
    );
  }
}
