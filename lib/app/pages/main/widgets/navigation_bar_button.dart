import 'package:flutter/material.dart';

import 'package:to_do/core/theme.dart';

class NavigationBarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavigationBarButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 8,
          right: isActive ? 0 : 8,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isActive ? AppColors.background : Colors.transparent,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withAlpha(0x80),
                      offset: const Offset(-4, 4),
                      blurRadius: 6,
                      spreadRadius: -4,
                    ),
                  ]
                : null,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive ? AppColors.primary : AppColors.textDark,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                    color: isActive ? AppColors.primary : AppColors.textDark,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
