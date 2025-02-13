import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do/share/utils/bindings.dart';

import 'package:to_do/pages/todo/todo_page.dart';
import 'package:to_do/pages/life/life_page.dart';


abstract class Routes {
  static const main = '/';
  static const todo = '/todo';
  static const life = '/life';
}

Route<dynamic>? onGenerateRoute(settings) {
  if (settings.name == Routes.todo) {
    return GetPageRoute(
      settings: settings,
      page: () => const TodoPage(),
      binding: TodoBinding(),
      transition: Transition.noTransition,
    );
  } else if (settings.name == Routes.life) {
    return GetPageRoute(
      settings: settings,
      page: () => const LifePage(),
      binding: LifeBinding(),
      transition: Transition.noTransition,
    );
  } else { return null; }
}
