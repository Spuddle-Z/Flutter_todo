import 'package:flutter/material.dart';
import 'package:to_do/core/theme.dart';

class MyCheckbox extends StatelessWidget {
  /// ### 勾选框
  ///
  /// 该组件用于显示一个可勾选的复选框。
  const MyCheckbox({
    super.key,
    required this.done,
    required this.color,
    required this.activeColor,
    required this.scale,
    required this.onChanged,
  });

  final bool done;
  final Color color;
  final Color activeColor;
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
          value: done,
          activeColor: activeColor,
          checkColor: AppColors.background,
          hoverColor: color.withAlpha(0x33),
          side: BorderSide(
            color: color,
            width: 2,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
