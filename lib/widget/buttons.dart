import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/popup.dart';
import '../theme.dart';

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