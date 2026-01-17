import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/pages/todo/widgets/routine_add_popup.dart';
import 'package:to_do/app/shared/widgets/border_top_tile.dart';
import 'package:to_do/app/shared/widgets/my_icon_button.dart';
import 'package:to_do/app/shared/widgets/my_text_button.dart';
import 'package:to_do/core/theme.dart';

class RoutineEditPopupController extends GetxController {
  RoutineEditPopupController();

  final MainController mainController = Get.find<MainController>();

  List<dynamic> get keys => mainController.routineBox.value.keys.toList();
}

class RoutineEditPopup extends StatelessWidget {
  /// ### 日程编辑弹窗
  ///
  /// 该组件用于显示日程编辑的弹窗界面。
  const RoutineEditPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final RoutineEditPopupController routineEditPopupController =
        Get.put(RoutineEditPopupController());
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: Get.width * 0.2,
        height: Get.height * 0.4,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: MyColors.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Manage Routines',
                style: TextStyle(
                  color: MyColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: MyColors.backgroundDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(() {
                  return ListView.builder(
                    itemCount: routineEditPopupController.keys.length,
                    itemBuilder: (context, index) {
                      final key = routineEditPopupController.keys[index];
                      final routine = routineEditPopupController
                          .mainController.routineBox.value
                          .get(key)!;
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: BorderTopTile(
                          color: MyColors.text,
                          isMini: false,
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  routine.content,
                                  style: const TextStyle(
                                    color: MyColors.text,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              MyIconButton(
                                icon: const Icon(Icons.close),
                                color: MyColors.text,
                                onPressed: () {
                                  routineEditPopupController.mainController
                                      .deleteRoutine(key);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyTextButton(
                  icon: Icons.add,
                  text: 'Add Routine',
                  color: MyColors.text,
                  onPressed: () {
                    Get.dialog(const RoutineAddPopup());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
