import 'package:flutter/material.dart';
import '../theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.maxLines,
  });

  final Function(String) onChanged;
  final String hintText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        expands: maxLines == null,
        maxLines: maxLines,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          color: AppColors.text,
        ),
        cursorColor: AppColors.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.textDark,
          ),
          filled: true,
          fillColor: AppColors.backgroundDark,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.backgroundDark, 
              width: 2
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.primary, 
              width: 2
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.red,
              width: 2
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
