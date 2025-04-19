import 'package:get/get.dart';

class QrScannerController extends GetxController {
  final RxBool isScanning = false.obs;
  final RxString scannedData = ''.obs;

  void startScanning() {
    isScanning.value = true;
    // In a real app, this would initiate the camera and QR scanning
  }

  void stopScanning() {
    isScanning.value = false;
  }

  void onQrDetected(String data) {
    scannedData.value = data;
    isScanning.value = false;
    
    // In a real app, this would handle the scanned data, possibly navigating to another screen
    Get.snackbar(
      'QR Code Scanned',
      'Successfully scanned QR code',
      snackPosition: SnackPosition.BOTTOM,
    );
    
    // Navigate back after scanning
    Future.delayed(Duration(seconds: 2), () {
      Get.back(result: data);
    });
  }

  void scanLater() {
    Get.back();
  }
} 