import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class LocationController extends GetxController {
  final RxBool isLocationDetected = false.obs;
  final RxString currentLocation = ''.obs;
  
  void scanQrCode() {
    // In a real app, this would access the camera and scan a QR code
    Get.toNamed(Routes.LOCATION_QR);
  }
  
  void selectLocationManually() {
    // Navigate to manual location selection
    Get.toNamed(Routes.LOCATION_MANUAL);
  }
  
  void useCurrentLocation() {
    // In a real app, this would get the user's current location
    isLocationDetected.value = true;
    currentLocation.value = 'Current Location';
    
    // Navigate to restaurants
    Get.toNamed(Routes.RESTAURANTS);
  }
  
  void enterNewLocation() {
    // In a real app, this would let the user type in a new location
    Get.toNamed(Routes.RESTAURANTS);
  }
  
  void continueToRestaurants() {
    // Navigate to restaurants list
    Get.toNamed(Routes.RESTAURANTS);
  }
} 