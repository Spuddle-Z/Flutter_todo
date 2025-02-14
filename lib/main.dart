import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';

import 'package:to_do/pages/todo/utils/task_model.dart';
import 'package:to_do/pages/main/main_page.dart';

import 'package:to_do/share/theme.dart';


void main() async{
  // 调用数据库
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init("data");
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  await Hive.openBox<bool>('Sports');
  await Hive.openBox<bool>('Relax');
  await Hive.openBox<bool>('Rise');
  await Hive.openBox<bool>('Sleep');

  // 默认全屏
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(fullScreen: true);
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setFullScreen(true);
    await windowManager.show();
  });

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
      home: MainPage(),
    );
  }
}
