import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pop_up.dart';
import '../theme.dart';

class ButtonsArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
    return TextButton(
      onPressed: () {
        Get.dialog(
          AddTaskPopUp()
        );
      },
      style: textButtonStyle(),
      child: const Icon(
        Icons.add,
        color: AppColors.text,
      ),
    );
  }
}