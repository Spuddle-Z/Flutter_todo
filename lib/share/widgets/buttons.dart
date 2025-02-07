import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/pages/todo/modules/popup.dart';
import 'package:to_do/share/theme.dart';


class ButtonsArea extends StatelessWidget {
  const ButtonsArea({super.key});

  @override
  Widget build(BuildContext context) {    
    return TextButton(
      onPressed: () {
        Get.dialog(
          AddTaskPopup(),
          barrierDismissible: false,
        );
      },
      style: textButtonStyle(),
      child: const Row(
        children: [
          Icon(
            Icons.add,
            color: AppColors.text,
          ),
          Text(
            'Add Task',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}