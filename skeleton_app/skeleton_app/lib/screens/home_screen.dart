import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../widgets/custom_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Obx(() => IconButton(
            icon: Icon(
              themeController.isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: themeController.toggleTheme,
          )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Skeleton App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'This is a sample app built with Flutter and GetX',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            CustomCard(
              title: 'Sample Card',
              subtitle: 'This is a reusable custom card widget',
              leading: const Icon(Icons.info),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.snackbar(
                  'Tapped',
                  'You tapped the card!',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 