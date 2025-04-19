import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../../core/utils/theme_service.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeService>(() => ThemeService());
    Get.lazyPut<HomeController>(() => HomeController());
  }
} 