import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../services/navigation_service.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Register services
    Get.putAsync<NavigationService>(() => NavigationService().init());
    
    // Register controllers
    Get.put(NavigationController());
  }
} 