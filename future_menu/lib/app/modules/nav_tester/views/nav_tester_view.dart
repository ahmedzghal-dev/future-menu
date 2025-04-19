import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nav_tester_controller.dart';
import '../../../services/navigation_service.dart';

class NavTesterView extends GetView<NavTesterController> {
  const NavTesterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Tester'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => NavigationService.to.navigateAndRemoveUntil(
              NavigationService.to.availableRoutes.first['route'],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildNavigationGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'App Navigation Tester',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This screen allows you to navigate to any screen in the app for testing purposes.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber, width: 1),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.amber),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Some screens may require specific parameters to function correctly. Navigation errors will be shown as notifications.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: NavigationService.to.availableRoutes.length,
      itemBuilder: (context, index) {
        final routeInfo = NavigationService.to.availableRoutes[index];
        return _buildNavigationCard(context, routeInfo);
      },
    );
  }

  Widget _buildNavigationCard(BuildContext context, Map<String, dynamic> routeInfo) {
    return InkWell(
      onTap: () => NavigationService.to.navigateTo(routeInfo['route']),
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                routeInfo['icon'] ?? Icons.screen_share,
                size: 48,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 12),
              Text(
                routeInfo['name'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                routeInfo['route'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 