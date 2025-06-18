import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:to_do/core/theme.dart';

class DateTextFieldController extends GetxController {
  DateTextFieldController({required this.initialDate});

  final String initialDate;
  final TextEditingController textController = TextEditingController();
  late RxnString errorText;

  @override
  void onInit() {
    super.onInit();
    // 初始化文本控制器为当前日期，格式为 YYYYMMDD
    textController.text = initialDate;
    errorText = RxnString(); // 初始化错误文本为 null
  }

  /// 检查日期输入是否符合 YYYYMMDD 格式，同时检查日期是否合法。
  bool isDateValid() {
    if (textController.text.isEmpty) {
      errorText.value = null;
      return true;
    } else if (textController.text.length != 8) {
      errorText.value = '请按照 YYYYMMDD 格式输入';
      return false;
    } else {
      // 尝试解析日期
      final year = int.tryParse(textController.text.substring(0, 4));
      final month = int.tryParse(textController.text.substring(4, 6));
      final day = int.tryParse(textController.text.substring(6, 8));
      // 检查年、月、日是否为有效数字
      if (year == null || month == null || day == null) {
        errorText.value = '请按照 YYYYMMDD 格式输入';
        return false;
      }
      // 检查日期是否合法
      if (month < 1 ||
          month > 12 ||
          day < 1 ||
          day > DateUtils.getDaysInMonth(year, month)) {
        errorText.value = '日期不合法';
        return false;
      } else {
        errorText.value = null;
        return true;
      }
    }
  }
}

class DateTextField extends StatelessWidget {
  /// ### 日期输入框
  ///
  /// 该输入框用于输入日期，输入格式为8位数字，表示年月日（YYYYMMDD）。如果输入不符合要求，将显示错误提示。
  const DateTextField({
    super.key,
    required this.initialDate,
    required this.onChanged,
  });

  final String initialDate;
  final void Function(String, bool) onChanged;

  @override
  Widget build(BuildContext context) {
    final DateTextFieldController dateTextFieldController =
        Get.put(DateTextFieldController(initialDate: initialDate));

    return Obx(() {
      return TextField(
        // 样式设置
        cursorColor: AppColors.text,
        style: const TextStyle(
          color: AppColors.text,
        ),
        decoration: textFieldStyle(
          hintText: '无截止日期',
          errorText: dateTextFieldController.errorText.value,
        ),

        // 功能设置
        controller: dateTextFieldController.textController,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(8),
        ],
        onChanged: (input) {
          onChanged(input, dateTextFieldController.isDateValid());
        },
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
      );
    });
  }
}
