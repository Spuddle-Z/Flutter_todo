import 'package:flutter/material.dart';

// 带有顶部边框的面板
class BorderTopTile extends Container {
  BorderTopTile({
    super.key,
    required Color color,
    bool isMini = false,
    required Widget child,
  }) : super(
          child: child,
          decoration: BoxDecoration(
            color: color.withAlpha(0x33),
            borderRadius: BorderRadius.circular(isMini ? 4 : 8),
            border: Border(
              top: BorderSide(
                color: color,
                width: isMini ? 2 : 3,
              ),
            ),
          ),
          margin: EdgeInsets.all(isMini ? 2 : 4),
        );
}
