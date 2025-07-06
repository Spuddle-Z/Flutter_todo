import 'package:flutter/material.dart';
import 'package:to_do/core/theme.dart';

class DetailTile extends StatelessWidget {
  final String keyText;
  final Widget valueWidget;
  final bool isExpanded;

  /// ### 详细内容显示栏
  ///
  /// 该组件用于显示任务的详细信息，包括任务的截止日期、优先级和备注等。
  const DetailTile({
    super.key,
    required this.keyText,
    required this.valueWidget,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(8),
            width: 100,
            child: Text(
              keyText,
              style: const TextStyle(
                color: MyColors.text,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          isExpanded
              ? Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: MyColors.backgroundDark,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: valueWidget,
                  ),
                )
              : Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MyColors.backgroundDark,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: valueWidget,
                ),
        ],
      ),
    );
  }
}
