import 'package:flutter/material.dart';

import 'package:to_do/core/theme.dart';

// 截止日期显示栏
class DetailTile extends StatelessWidget {
  const DetailTile({
    super.key,
    required this.keyText,
    required this.valueWidget,
  });
  final String keyText;
  final Widget valueWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(8),
          width: 100,
          child: Text(
            keyText,
            style: const TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.backgroundDark,
            borderRadius: BorderRadius.circular(4),
          ),
          child: valueWidget,
        ),
      ],
    );
  }
}
