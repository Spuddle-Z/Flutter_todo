import 'package:flutter/material.dart';
import 'package:to_do/core/theme.dart';

// 下拉选择框
class DropdownSelector extends StatelessWidget {
  const DropdownSelector({
    super.key,
    required this.value,
    required this.isEnabled,
    required this.onChanged,
    required this.optionList,
    this.hintText = '',
    this.errorText = '',
  });

  final int? value;
  final bool isEnabled;
  final void Function(int?)? onChanged;
  final List<Widget> optionList;
  final String hintText;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      // 样式设置
      hint: Text(
        hintText,
        style: const TextStyle(
          color: AppColors.textDark,
        ),
      ),
      decoration: textFieldStyle(errorText),
      dropdownColor: AppColors.backgroundDark,
      elevation: 16,

      // 功能设置
      value: value,
      onChanged: isEnabled ? onChanged : null,
      items: [
        for (int i = 0; i < optionList.length; i++)
          DropdownMenuItem(
            value: i,
            child: optionList[i],
          ),
      ],
    );
  }
}
