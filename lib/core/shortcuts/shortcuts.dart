import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/core/shortcuts/intents.dart';

final Map<ShortcutActivator, Intent> shortcuts = {
  const SingleActivator(LogicalKeyboardKey.digit1): const ToTodoIntent(),
  const SingleActivator(LogicalKeyboardKey.digit2): const ToLifeIntent(),
  const SingleActivator(LogicalKeyboardKey.keyT, control: true):
      const AddTaskIntent(),
};
