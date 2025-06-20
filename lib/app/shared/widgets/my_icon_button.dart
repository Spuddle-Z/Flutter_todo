import 'package:flutter/material.dart';

// 任务单元上的各按钮
class MyIconButton extends IconButton {
  MyIconButton({
    super.key,
    required Widget icon,
    required Color color,
    required void Function() onPressed,
  }) : super(
          icon: icon,
          color: color,
          hoverColor: color.withAlpha(0x33),
          iconSize: 16,
          constraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          onPressed: onPressed,
        );
}
