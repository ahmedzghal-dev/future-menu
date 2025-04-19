import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../controllers/items_controller.dart';
import '../controllers/navigation_controller.dart';
import '../services/api_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Services
    Get.put(ApiService(), permanent: true);
    
    // Controllers
    Get.put(ThemeController(), permanent: true);
    Get.put(ItemsController());
    Get.put(NavigationController(), permanent: true);
  }
} 