import 'package:flutter/material.dart';
import 'package:to_do/app/pages/life/widgets/hot_map_day_cell.dart';
import 'package:to_do/app/shared/constants/hobby_constant.dart';
import 'package:to_do/core/theme.dart';

class HotMap extends StatelessWidget {
  /// ### 热力图组件
  ///
  /// 该组件用于显示热力图。
  const HotMap({
    super.key,
    required this.hobbyIndex,
  });

  final int hobbyIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 热力图标题
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              HobbyConstant.hobbyTitleList[hobbyIndex],
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // 热力图主体
        SizedBox(
          width: double.infinity,
          height: 120,
          child: Row(
            children: [
              // 星期几表头
              Expanded(
                flex: 1,
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  List<String> days = ['', 'Mon', '', 'Wed', '', 'Fri', ''];
                  double width = constraints.maxWidth;
                  double height = constraints.maxHeight / 7;

                  return GridView.builder(
                    itemCount: 7,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: width / height,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: width,
                        alignment: Alignment.center,
                        child: Text(
                          days[index],
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              // 热力图网格
              Expanded(
                flex: 16,
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  double cellWidth =
                      constraints.maxWidth / HobbyConstant.hotMapColumns;
                  double cellHeight =
                      constraints.maxHeight / HobbyConstant.hotMapRows;

                  return GridView.builder(
                      itemCount: HobbyConstant.hotMapRows *
                          HobbyConstant.hotMapColumns,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: HobbyConstant.hotMapColumns,
                        childAspectRatio: cellWidth / cellHeight,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return HotMapDayCell(
                          index: index,
                          hobbyIndex: hobbyIndex,
                        );
                      });
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
