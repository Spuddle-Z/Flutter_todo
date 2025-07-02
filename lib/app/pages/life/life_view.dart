import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/life/life_controller.dart';

import 'package:to_do/app/pages/life/widgets/hot_map.dart';
import 'package:to_do/app/pages/life/widgets/hobby_list.dart';
import 'package:to_do/app/shared/constants/hobby_constant.dart';
import 'package:to_do/app/shared/widgets/recessed_panel.dart';

import 'package:to_do/core/theme.dart';

class LifeView extends StatelessWidget {
  const LifeView({super.key});

  @override
  Widget build(BuildContext context) {
    final LifeController lifeController = Get.find<LifeController>();

    return Container(
      color: MyColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Row(
        children: [
          // 热力图
          Expanded(
              flex: 2,
              child: RecessedPanel(
                child: Column(
                  children: [
                    // 热力图年份栏
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () =>
                                    lifeController.viewYear.value -= 1,
                                icon: const Icon(Icons.keyboard_arrow_left),
                                color: MyColors.text,
                              ),
                              Container(
                                width: 80,
                                alignment: Alignment.center,
                                child: Obx(() {
                                  return Text(
                                    lifeController.viewYearString,
                                    style: const TextStyle(
                                      color: MyColors.primary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                              ),
                              IconButton(
                                onPressed: () =>
                                    lifeController.viewYear.value += 1,
                                icon: const Icon(Icons.keyboard_arrow_right),
                                color: MyColors.text,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: HobbyConstant.hobbyTitleList.length,
                      itemBuilder: (context, index) {
                        return HotMap(hobbyIndex: index);
                      },
                    )
                  ],
                ),
              )),
          // 习惯列表
          Expanded(
            flex: 1,
            child: RecessedPanel(
              child: const Row(
                children: [
                  Expanded(
                    child: HobbyList(isToday: false),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: HobbyList(isToday: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
