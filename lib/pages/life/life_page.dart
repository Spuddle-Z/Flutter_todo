import 'package:flutter/material.dart';
import 'package:to_do/pages/life/modules/hot_maps.dart';
import 'package:to_do/pages/life/modules/motto.dart';
import 'package:to_do/share/theme.dart';


class LifePage extends StatelessWidget {
  const LifePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: HotMapList()
          ),
          Expanded(
            flex: 1,
            child: MottoWidget(),
          ),
        ],
      ),
    );
  }
}