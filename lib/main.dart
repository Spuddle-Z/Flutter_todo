import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'util/task_model.dart';
import 'util/calendar_controller.dart';
import 'util/task_controller.dart';

import 'pages/todo_page.dart';
import 'theme.dart';


void main() async{
  // 调用数据库
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init("data");
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  // 全局注册控制器
  Get.lazyPut(() => CalendarController());
  Get.lazyPut(() => TaskController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      home: const Scaffold(
        backgroundColor: AppColors.background,
        body: TodoPage()
      ),
    );
  }
}
