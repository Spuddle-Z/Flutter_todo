import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'util/task_model.dart';
import 'util/task_controller.dart';
import 'util/tile_controller.dart';
import 'theme.dart';
import 'pages/todo_page.dart';

void main() async{
  // 调用数据库
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init("data");
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  // 全局注册控制器
  Get.lazyPut(() => TaskController());
  Get.lazyPut(() => TileController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To Do',
      theme: ThemeData(
        fontFamily: Platform.isWindows ? "微软雅黑" : null,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('To Do'),
        ),
        body: const TodoPage()
      ),
    );
  }
}
