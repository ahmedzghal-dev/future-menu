import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const ListTile(
            title: Text('Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          const Divider(),
          ListTile(
            title: const Text('Theme Mode'),
            subtitle: const Text('Toggle between light and dark theme'),
            trailing: Obx(() => Switch(
              value: themeController.isDarkMode,
              onChanged: (_) => themeController.toggleTheme(),
            )),
          ),
          const Divider(),
          ListTile(
            title: const Text('App Info'),
            subtitle: const Text('Version 1.0.0'),
            trailing: const Icon(Icons.info_outline),
            onTap: () {
              Get.dialog(
                AlertDialog(
                  title: const Text('About'),
                  content: const Text('Skeleton App with GetX.\nCreated as a template for Flutter projects.'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} 