import 'package:get/get.dart';
import '../bindings/app_bindings.dart';
import '../screens/main_screen.dart';
import '../screens/home_screen.dart';
import '../screens/tasks_screen.dart';
import '../screens/settings_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: Routes.MAIN,
      page: () => const MainScreen(),
      binding: AppBindings(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.TASKS,
      page: () => const TasksScreen(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsScreen(),
    ),
  ];
} 