import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/navigation_controller.dart';
import '../widgets/custom_bottom_navigation.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String currentRoute;
  final bool showBottomNav;
  final String title;
  final List<Widget> actions;
  final bool showBackButton;
  
  const MainLayout({
    Key? key,
    required this.child,
    required this.currentRoute,
    this.showBottomNav = true,
    this.title = '',
    this.actions = const [],
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Update the navigation controller with the current route
    if (showBottomNav) {
      NavigationController.to.updateIndexBasedOnRoute(currentRoute);
    }
    
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: actions,
        automaticallyImplyLeading: showBackButton,
      ),
      drawer: const AppNavigationDrawer(),
      body: child,
      bottomNavigationBar: showBottomNav
          ? Obx(() => CustomBottomNavigation(
              currentIndex: NavigationController.to.currentIndex.value,
              onTap: (index) {
                if (index == 4) {
                  // Handle "More" option by opening the drawer
                  scaffoldKey.currentState?.openDrawer();
                } else {
                  NavigationController.to.changePage(index);
                }
              },
            ))
          : null,
    );
  }
} 