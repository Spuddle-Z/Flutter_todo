import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:window_manager/window_manager.dart';

import 'package:to_do/app/data/models/item_model.dart';
import 'package:to_do/app/data/models/routine_model.dart';
import 'package:to_do/app/routes/route_pages.dart';
import 'package:to_do/app/routes/route_path.dart';

void main() async {
  // 调用数据库
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init("data");
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(RoutineAdapter());
  await Hive.openBox<Item>('Items');
  await Hive.openBox<Routine>('Routines');
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
      ),
      initialRoute: RoutePath.main,
      getPages: RoutePages.pages,
    );
  }
}
