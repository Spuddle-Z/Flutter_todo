import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'theme.dart';
import 'calendar.dart';
import 'task_list.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("taskBox");
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

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('To Do'),
      ),
      body: Row(
        children: [
          Expanded(child: CalendarWidget(
              selectedDay: _selectedDay,
              onDaySelected: (selectedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
            ),
          ),
          Expanded(child: TaskList()),
        ],
      ),
    );
  }
}