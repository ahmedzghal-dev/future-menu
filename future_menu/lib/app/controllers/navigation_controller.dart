import 'package:get/get.dart';
import '../routes/app_pages.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  
  final RxInt currentIndex = 0.obs;
  
  final List<String> navigationRoutes = [
    Routes.RESTAURANTS, // Home
    Routes.MENU,
    Routes.CART,
    Routes.VIRTUAL_ASSISTANT,
    '', // More (opens drawer)
  ];
  
  void changePage(int index) {
    if (index == 4) {
      // Handle "More" section (drawer will be shown)
      currentIndex.value = currentIndex.value; // Keep the current tab selected
      return;
    }
    
    currentIndex.value = index;
    Get.offAllNamed(navigationRoutes[index]);
  }
  
  void updateIndexBasedOnRoute(String route) {
    final index = navigationRoutes.indexOf(route);
    if (index != -1 && index != 4) { // Exclude the "More" option
      currentIndex.value = index;
    }
  }
} 