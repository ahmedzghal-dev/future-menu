import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class QRCode {
  final String id;
  final String content;
  final String type;
  final String title;
  final String description;
  final DateTime createdAt;
  final String? imageUrl;

  QRCode({
    required this.id,
    required this.content,
    required this.type,
    required this.title,
    required this.description,
    required this.createdAt,
    this.imageUrl,
  });
}

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final isLoading = false.obs;
  final RxList<QRCode> qrCodes = <QRCode>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadQRCodes();
  }

  Future<void> loadQRCodes() async {
    isLoading.value = true;
    
    // Simulate loading data from a database
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, populate with sample data
    // In a real app, this would fetch from a local database or API
    qrCodes.value = [
      QRCode(
        id: '1',
        content: 'https://flutter.dev',
        type: 'URL',
        title: 'Flutter Website',
        description: 'Official website for Flutter development',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      QRCode(
        id: '2',
        content: 'WIFI:S:MyNetwork;T:WPA;P:password123;;',
        type: 'WiFi',
        title: 'Home WiFi',
        description: 'WiFi password for home network',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      QRCode(
        id: '3',
        content: 'BEGIN:VCARD\nVERSION:3.0\nFN:John Doe\nTEL:+123456789\nEMAIL:john@example.com\nEND:VCARD',
        type: 'Contact',
        title: 'John Doe',
        description: 'Contact information for John',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
    
    isLoading.value = false;
  }

  Future<void> refreshQRCodes() async {
    await loadQRCodes();
  }

  void navigateToScanner() {
    Get.toNamed(AppConstants.scannerRoute);
  }

  void navigateToDetails(QRCode qrCode) {
    Get.toNamed(
      AppConstants.detailsRoute,
      arguments: qrCode,
    );
  }

  void navigateToProfile() {
    Get.toNamed(AppConstants.profileRoute);
  }

  void deleteQRCode(String id) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete QR Code'),
        content: const Text('Are you sure you want to delete this QR code?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Remove the QR code from the list
              qrCodes.removeWhere((code) => code.id == id);
              
              // Show success message
              Get.back();
              Get.snackbar(
                'Success',
                'QR code deleted successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year(s) ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month(s) ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day(s) ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour(s) ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute(s) ago';
    } else {
      return 'Just now';
    }
  }
} 