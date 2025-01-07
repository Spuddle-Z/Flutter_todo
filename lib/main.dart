import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'util/task_model.dart';
import 'util/task_controller.dart';
import 'theme.dart';
import 'pages/todo_page.dart';

void main() async{
  // 调用数据库
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init("data");
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  // 全局注册控制器
  Get.put(TaskController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
      home: Container(
        color: AppColors.background,
        child: TodoPage()
      ),
    );
  }
}
