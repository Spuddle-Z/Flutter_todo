import 'package:flutter/material.dart';
import 'package:to_do/core/theme.dart';

// 下拉选择框
class DropdownSelector extends StatelessWidget {
  const DropdownSelector({
    super.key,
    required this.initValue,
    required this.isEnabled,
    required this.onChanged,
    required this.optionList,
    this.hintText = '',
    this.errorText,
  });

  final int? initValue;
  final bool isEnabled;
  final void Function(int?)? onChanged;
  final List<Widget> optionList;
  final String hintText;
  final String? errorText;

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
      decoration: textFieldStyle(
        hintText: hintText,
        errorText: errorText,
      ),
      dropdownColor: AppColors.backgroundDark,
      elevation: 16,

      // 功能设置
      value: initValue,
      onChanged: isEnabled ? onChanged : null,
      items: List<DropdownMenuItem<int>>.generate(
        optionList.length,
        (index) => DropdownMenuItem<int>(
          value: index,
          child: optionList[index],
        ),
      ),
    );
  }
}
