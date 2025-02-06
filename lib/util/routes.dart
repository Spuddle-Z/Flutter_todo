import 'package:get/get.dart';

import 'package:to_do/util/bindings.dart';

import 'package:to_do/pages/main_page.dart';
import 'package:to_do/pages/todo_page.dart';
import 'package:to_do/pages/life_page.dart';


abstract class Routes {
  static const main = '/';
  static const todo = '/todo';
  static const life = '/life';
}

class RoutePages {
  static final pages = [
    GetPage(
      name: Routes.main,
      page: () => MainPage(),
      binding: MainBinding(),
      children: [
        GetPage(
          name: Routes.todo,
          page: () => const TodoPage(),
          binding: TodoBinding(),
        ),
        GetPage(
          name: Routes.life,
          page: () => const LifePage()
        ),
      ],
    ),
  ];
}
