import 'package:get/get.dart';

import 'package:to_do/app/pages/life/life_binding.dart';
import 'package:to_do/app/pages/life/life_view.dart';
import 'package:to_do/app/pages/main/main_binding.dart';
import 'package:to_do/app/pages/main/main_view.dart';
import 'package:to_do/app/pages/todo/todo_binding.dart';
import 'package:to_do/app/pages/todo/todo_view.dart';

import 'package:to_do/app/routes/route_path.dart';

class RoutePages {
  static final List<GetPage> pages = [
    GetPage(
      name: RoutePath.main,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: RoutePath.todo,
      page: () => TodoView(),
      binding: TodoBinding(),
    ),
    GetPage(
      name: RoutePath.life,
      page: () => LifeView(),
      binding: LifeBinding(),
    ),
  ];
}
