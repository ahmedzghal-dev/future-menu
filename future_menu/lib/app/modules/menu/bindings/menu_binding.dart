import 'package:get/get.dart';
import '../controllers/menu_controller.dart' as app_menu;

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<app_menu.MenuController>(
      () => app_menu.MenuController(),
    );
  }
} 