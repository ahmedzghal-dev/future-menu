import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../widgets/custom_bottom_navigation.dart';
import 'home_screen.dart';
import 'tasks_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.find<NavigationController>();
    
    final screens = [
      const HomeScreen(),
      const TasksScreen(),
      const SettingsScreen(),
    ];
    
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: screens,
      )),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
} 