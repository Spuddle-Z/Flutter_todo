import 'package:flutter/material.dart';
import 'package:to_do/core/theme.dart';

class MyTextButton extends StatelessWidget {
  final IconData? icon; // 按钮图标
  final String? text; // 按钮文本
  final VoidCallback onPressed; // 按钮点击事件
  final Color color; // 按钮颜色

  /// ### 文字按钮
  ///
  /// 该组件为一个自定义的文字按钮。
  const MyTextButton({
    super.key,
    this.icon,
    this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: textButtonStyle(),
      child: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(
                icon,
                color: color,
              ),
            ),
          if (text != null)
            Text(
              text!,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
