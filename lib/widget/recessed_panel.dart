import 'package:flutter/material.dart';
import '../theme.dart';


// 深色凸出面板
class RecessedPanel extends Container {
  RecessedPanel({super.key, required Widget child}): super(
    child: child,
    decoration: BoxDecoration(
      color: AppColors.backgroundDark,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(0x80),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(8),
  );
}