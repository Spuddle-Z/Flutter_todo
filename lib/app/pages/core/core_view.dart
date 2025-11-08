import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/core/core_controller.dart';
import 'package:to_do/app/shared/widgets/item_tile.dart';
import 'package:to_do/core/theme.dart';

class CoreView extends GetView<CoreController> {
  const CoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final CoreController coreController = Get.find<CoreController>();

    return Container(
      color: MyColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Obx(() {
        final keys = coreController.keys;
        return ListView.builder(
          itemCount: keys.length,
          itemBuilder: (context, index) {
            return ItemTile(
              itemKey: keys[index],
              isMiniTile: false,
            );
          },
        );
      }),
    );
  }
}
