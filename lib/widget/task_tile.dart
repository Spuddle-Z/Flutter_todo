import 'package:flutter/material.dart';
import '../theme.dart';

class TaskTile extends StatefulWidget {
  final String taskContent;
  final bool taskDone;
  final int taskPriority;

  const TaskTile({
    super.key,
    required this.taskContent,
    required this.taskDone,
    required this.taskPriority,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool _taskDone = false;

  void toggleTaskDone(int index) {
    setState(() {
      _taskDone = !_taskDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color tile_color;
    switch (widget.taskPriority) {
      case 0:
        tile_color = AppColors.red;
        break;
      case 1:
        tile_color = AppColors.primary;
        break;
      case 2:
        tile_color = AppColors.green;
        break;
      default:
        tile_color = AppColors.textActive;
    }

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        child: Row(
          children: [
            Text(
              widget.taskContent,
              style: TextStyle(
                color: tile_color,
                fontSize: 16,
              ),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: tile_color.withAlpha(0x33),
          borderRadius: BorderRadius.circular(8),
          border: Border(
            top: BorderSide(color: tile_color, width: 3), // 顶部不透明的杠
          ),
        ),
      ),
    );
  }
}