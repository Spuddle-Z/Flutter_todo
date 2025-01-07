import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'util/task_model.dart';
import 'theme.dart';
import 'pages/todo_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init("data");
  Hive.registerAdapter(TaskAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            fontSize: 16,
            color: AppColors.text,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
      home: TodoPage(),
    );
  }
}
