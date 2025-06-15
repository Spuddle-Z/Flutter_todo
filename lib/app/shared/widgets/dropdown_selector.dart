import 'package:flutter/material.dart';
import 'package:to_do/core/theme.dart';

class GenericDropdownSelector<T> extends StatelessWidget {
  final String hintText;
  final T? value;
  final List<T> options;
  final String Function(T) itemLabelBuilder;
  final void Function(T?)? onChanged;
  final bool isEnabled;
  final Color dropdownColor;

  const GenericDropdownSelector({
    super.key,
    required this.hintText,
    required this.value,
    required this.options,
    required this.itemLabelBuilder,
    this.onChanged,
    this.isEnabled = true,
    this.dropdownColor = AppColors.backgroundDark,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      hint: Text(
        hintText,
        style: const TextStyle(color: AppColors.textDark),
      ),
      decoration: textFieldStyle(''),
      dropdownColor: dropdownColor,
      elevation: 16,
      value: value,
      onChanged: isEnabled ? onChanged : null,
      items: options
          .map((option) => DropdownMenuItem(
                value: option,
                child: Text(
                  itemLabelBuilder(option),
                  style: const TextStyle(color: AppColors.text),
                ),
              ))
          .toList(),
    );
  }
}
