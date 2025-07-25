import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/theme.dart';

class MyTextFieldController extends GetxController {
  MyTextFieldController({required this.initialText});

  final String initialText;
  final TextEditingController textController = TextEditingController();
  RxnString errorText = RxnString();

  @override
  void onInit() {
    super.onInit();
    textController.text = initialText;
    errorText.value = null; // 初始化错误文本为 null
  }
}

class MyTextField extends StatelessWidget {
  final String initialText;
  final String hintText;
  final bool isMultiLine;
  final String? Function(String) onChanged;

  /// ### 文本输入框
  ///
  /// 该输入框用于输入文本，可以设置为单行或多行输入。
  const MyTextField({
    super.key,
    required this.initialText,
    required this.hintText,
    required this.isMultiLine,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final MyTextFieldController myTextFieldController = Get.put(
        MyTextFieldController(initialText: initialText),
        tag: UniqueKey().toString());

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Obx(() {
        return TextField(
          // 样式设置
          expands: isMultiLine,
          maxLines: isMultiLine ? null : 1,
          textAlignVertical: TextAlignVertical.top,
          cursorColor: MyColors.text,
          style: const TextStyle(
            color: MyColors.text,
          ),
          decoration: textFieldStyle(
            hintText: hintText,
            errorText: myTextFieldController.errorText.value,
          ),

          // 功能设置
          controller: myTextFieldController.textController,
          onChanged: (input) {
            myTextFieldController.errorText.value = onChanged(input);
          },
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
        );
      }),
    );
  }
}
