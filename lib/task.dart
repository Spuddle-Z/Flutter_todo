// import 'package:flutter/material.dart';

class Task {
  final int id;
  String content;
  String? notes;
  DateTime due;
  Duration? cycle;
  int priority;

  Task({
    required this.id,
    required this.content,
    required this.due,
    this.notes,
    this.cycle,
    this.priority = 0,
  });
}