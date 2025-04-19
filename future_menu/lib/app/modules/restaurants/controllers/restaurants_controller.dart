import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class RestaurantsController extends GetxController {
  final RxString selectedLocation = 'Gram Bistro'.obs;
  final RxList<Map<String, String>> restaurants = <Map<String, String>>[
    {
      'name': 'Gram Bistro',
      'address': '750 8th Ave, New York',
    },
    {
      'name': 'Bin 71',
      'address': '792 8th Ave, New York',
    },
    {
      'name': 'Sushi Bar',
      'address': '794 8th Ave, New York',
    }
  ].obs;
  
  final RxInt selectedRestaurantIndex = 0.obs;
  
  void selectRestaurant(int index) {
    selectedRestaurantIndex.value = index;
    selectedLocation.value = restaurants[index]['name'] ?? '';
  }
  
  void continueToVirtualAssistant() {
    // Navigate to virtual assistant
    Get.toNamed(Routes.VIRTUAL_ASSISTANT);
  }
  
  void continueToMenu() {
    // Navigate to menu
    Get.toNamed(Routes.MENU);
  }
} 