import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../services/navigation_service.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu),
          label: 'Menu',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.support_agent),
          label: 'Assistant',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: 'More',
        ),
      ],
    );
  }
}

// This handles showing the "More" section with all available routes
class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navService = Get.find<NavigationService>();
    
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restaurant,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'EatEasy Navigation',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Access all screens',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: navService.availableRoutes.length,
              itemBuilder: (context, index) {
                final routeInfo = navService.availableRoutes[index];
                return ListTile(
                  leading: Icon(
                    routeInfo['icon'] ?? Icons.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(routeInfo['name']),
                  subtitle: Text(
                    routeInfo['route'],
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    navService.navigateWithReplacement(routeInfo['route']);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 