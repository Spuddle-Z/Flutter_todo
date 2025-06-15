import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF2A2D3E);
  static const Color backgroundActive = Color(0xFF404D6F);
  static const Color backgroundLight = Color(0xFF393F57);
  static const Color backgroundDark = Color(0xFF1B1F2B);
  static const Color primary = Color(0xFF73B4D4);
  static const Color text = Color(0xFFB6B8CF);
  static const Color textActive = Color(0xFFFFCB6B);
  static const Color textDark = Color(0xFF666E95);

  static const Color red = Color(0xFFD04255);
  static const Color green = Color(0xFF73BBB2);
  static const Color purple = Color(0xFF9E86C8);
}

// 按钮样式
ButtonStyle textButtonStyle() {
  return ButtonStyle(
    foregroundColor:
        WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      return AppColors.text;
    }),
    backgroundColor:
        WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return AppColors.backgroundActive;
      } else if (states.contains(WidgetState.hovered)) {
        return AppColors.backgroundLight;
      }
      return AppColors.background;
    }),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    textStyle:
        WidgetStateProperty.resolveWith<TextStyle>((Set<WidgetState> states) {
      return const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
    }),
  );
}

// 输入框样式
InputDecoration textFieldStyle(String hintText, [String? errorText]) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(
      color: AppColors.textDark,
    ),
    filled: true,
    fillColor: AppColors.backgroundDark,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.backgroundDark, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    errorText: errorText,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.red, width: 2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.red, width: 2),
    ),
  );
}
