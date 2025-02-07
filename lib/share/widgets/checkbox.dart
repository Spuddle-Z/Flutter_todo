import 'package:flutter/material.dart';

import 'package:to_do/share/theme.dart';


// 勾选框
class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({
    super.key,
    required this.taskDone,
    required this.tileColor,
    required this.scale,
    required this.onChanged,
  });

  final bool taskDone;
  final Color tileColor;
  final double scale;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30 * scale,
      height: 30 * scale,
      child: Transform.scale(
        scale: scale,
        child: Checkbox(
          value: taskDone,
          activeColor: tileColor,
          checkColor: AppColors.background,
          hoverColor: tileColor.withAlpha(0x33),
          side: BorderSide(
            color: tileColor,
            width: 2,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
