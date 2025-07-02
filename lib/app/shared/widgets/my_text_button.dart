import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/app/pages/todo/widgets/item_popup.dart';
import 'package:to_do/core/theme.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.dialog(
          const ItemPopup(),
          barrierDismissible: false,
        );
      },
      style: textButtonStyle(),
      child: const Row(
        children: [
          Icon(
            Icons.add,
            color: MyColors.text,
          ),
          Text(
            'Add Task',
            style: TextStyle(
              color: MyColors.text,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
