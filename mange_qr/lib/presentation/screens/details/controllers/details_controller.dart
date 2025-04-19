import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/constants.dart';
import '../../../screens/home/controllers/home_controller.dart';

class DetailsController extends GetxController {
  late RxString qrContent;
  late RxString qrType;
  late RxString qrTitle;
  late RxString qrDescription;
  late RxBool isGenerated;
  
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
  void onInit() {
    super.onInit();
    
    if (Get.arguments is QRCode) {
      // Coming from home screen (existing QR code)
      final QRCode qrCode = Get.arguments as QRCode;
      qrContent = qrCode.content.obs;
      qrType = qrCode.type.obs;
      qrTitle = qrCode.title.obs;
      qrDescription = qrCode.description.obs;
      isGenerated = false.obs;
      
      titleController.text = qrCode.title;
      descriptionController.text = qrCode.description;
    } else {
      // Coming from scanner (new QR code)
      final Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;
      qrContent = (args['content'] as String? ?? '').obs;
      qrType = (args['type'] as String? ?? 'TEXT').obs;
      qrTitle = ''.obs;
      qrDescription = ''.obs;
      isGenerated = (args['isGenerated'] as bool? ?? false).obs;
      
      // Generate a default title based on type
      String defaultTitle = '';
      if (qrType.value == 'URL') {
        defaultTitle = 'Website Link';
      } else if (qrType.value == 'WIFI') {
        defaultTitle = 'Wi-Fi Network';
      } else if (qrType.value == 'CONTACT') {
        defaultTitle = 'Contact Information';
      } else if (qrType.value == 'EMAIL') {
        defaultTitle = 'Email Address';
      } else if (qrType.value == 'PHONE') {
        defaultTitle = 'Phone Number';
      } else {
        defaultTitle = 'Text Note';
      }
      
      titleController.text = defaultTitle;
      descriptionController.text = 'Scanned on ${DateTime.now().toLocal().toString().split(' ')[0]}';
    }
  }
  
  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }
  
  void saveQRCode() {
    if (formKey.currentState!.validate()) {
      // Get reference to the HomeController
      final HomeController homeController = Get.find<HomeController>();
      
      // Create a new QR code object with a unique ID
      final newQRCode = QRCode(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: qrContent.value,
        type: qrType.value,
        title: titleController.text,
        description: descriptionController.text,
        createdAt: DateTime.now(),
      );
      
      // Add it to the list of QR codes
      homeController.qrCodes.add(newQRCode);
      
      // Show success message
      Get.snackbar(
        'Success',
        'QR Code saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      // Navigate back to home screen after a short delay
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.until((route) => Get.currentRoute == AppConstants.homeRoute);
      });
    }
  }
  
  void shareQRCode() {
    Get.snackbar(
      'Sharing',
      'Sharing QR Code...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
} 