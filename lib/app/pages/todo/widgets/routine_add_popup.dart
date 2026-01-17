import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/data/models/routine_model.dart';
import 'package:to_do/app/pages/main/main_controller.dart';
import 'package:to_do/app/shared/widgets/my_text_button.dart';
import 'package:to_do/app/shared/widgets/my_text_field.dart';
import 'package:to_do/core/theme.dart';

class RoutineAddPopupController extends GetxController {
  RoutineAddPopupController();

  final MainController mainController = Get.find<MainController>();

  // 状态变量
  final RxString content = ''.obs;

  // 计算变量
  bool get isContentValid => content.value.trim().isNotEmpty;

  String? onContentChanged(String input) {
    content.value = input;
    return isContentValid ? null : '日程内容不能为空';
  }

  /// 提交日程
  void onSubmit() {
    if (isContentValid) {
      Routine newRoutine = Routine(
        content: content.value.trim(),
      );
      mainController.addRoutine(newRoutine);
      Get.back();
    }
  }
}

class RoutineAddPopup extends StatelessWidget {
  /// ### 日程添加弹窗
  ///
  /// 该组件用于显示日程添加的弹窗界面。
  const RoutineAddPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final RoutineAddPopupController routineAddPopupController =
        Get.put(RoutineAddPopupController());
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: Get.width * 0.3,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: MyColors.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                'Add Routine',
                style: TextStyle(
                  color: MyColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            MyTextField(
              initialText: '',
              hintText: '什么事儿能每天干一遍？',
              isMultiLine: false,
              onChanged: routineAddPopupController.onContentChanged,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyTextButton(
                  onPressed: routineAddPopupController.onSubmit,
                  icon: Icons.add,
                  text: 'Add',
                  color: MyColors.text,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
