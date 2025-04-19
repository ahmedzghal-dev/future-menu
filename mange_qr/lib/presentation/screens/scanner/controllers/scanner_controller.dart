import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/constants/constants.dart';

class ScannerController extends GetxController {
  late MobileScannerController scannerController;
  
  final RxBool hasScanned = false.obs;
  final RxBool isFlashOn = false.obs;
  final RxString scannedResult = ''.obs;
  
  final RxBool isGenerateMode = false.obs;
  final TextEditingController textController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
  void onInit() {
    super.onInit();
    scannerController = MobileScannerController(
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }
  
  void onDetect(BarcodeCapture capture) {
    if (!hasScanned.value && capture.barcodes.isNotEmpty) {
      final String? code = capture.barcodes.first.rawValue;
      if (code != null) {
        hasScanned.value = true;
        scannedResult.value = code;
        
        // Pause scanning
        scannerController.stop();
        
        // Show result dialog
        Get.dialog(
          AlertDialog(
            title: const Text('QR Code Result'),
            content: Text(code),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  hasScanned.value = false;
                  scannerController.start();
                },
                child: const Text('Scan Again'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.toNamed(
                    AppConstants.detailsRoute,
                    arguments: {
                      'content': code,
                      'type': _determineQRType(code),
                    },
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      }
    }
  }
  
  void toggleFlash() async {
    isFlashOn.value = !isFlashOn.value;
    await scannerController.toggleTorch();
  }
  
  void toggleCamera() async {
    await scannerController.switchCamera();
  }
  
  void toggleMode() {
    isGenerateMode.value = !isGenerateMode.value;
    if (!isGenerateMode.value) {
      // When switching back to scanner, resume camera
      scannerController.start();
    } else {
      // When switching to generator, pause camera
      scannerController.stop();
    }
  }
  
  String? validateQRContent(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter content for the QR code';
    }
    return null;
  }
  
  void generateQRCode() {
    if (formKey.currentState!.validate()) {
      // Navigate to details screen with the content to generate
      Get.toNamed(
        AppConstants.detailsRoute,
        arguments: {
          'content': textController.text,
          'type': _determineQRType(textController.text),
          'isGenerated': true,
        },
      );
    }
  }
  
  String _determineQRType(String content) {
    if (content.startsWith('BEGIN:VCARD')) {
      return 'CONTACT';
    } else if (content.startsWith('WIFI:')) {
      return 'WIFI';
    } else if (content.startsWith('http://') || content.startsWith('https://')) {
      return 'URL';
    } else if (content.contains('@') && content.contains('.')) {
      return 'EMAIL';
    } else if (content.startsWith('tel:') || content.startsWith('+') || content.replaceAll(RegExp(r'[^\d]'), '').length > 8) {
      return 'PHONE';
    } else {
      return 'TEXT';
    }
  }
  
  @override
  void onClose() {
    scannerController.dispose();
    textController.dispose();
    super.onClose();
  }
} 