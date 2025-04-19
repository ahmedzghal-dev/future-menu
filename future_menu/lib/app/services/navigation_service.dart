import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class NavigationService extends GetxService {
  static NavigationService get to => Get.find<NavigationService>();

  // List of all available routes for navigation
  List<Map<String, dynamic>> get availableRoutes => [
    {'name': 'Splash', 'route': Routes.SPLASH, 'icon': Icons.screenshot},
    {
      'name': 'Onboarding',
      'route': Routes.ONBOARDING,
      'icon': Icons.mobile_screen_share,
    },
    {
      'name': 'Authentication',
      'route': Routes.AUTHENTICATION,
      'icon': Icons.login,
    },
    {
      'name': 'Email Verification',
      'route': Routes.EMAIL_VERIFICATION,
      'icon': Icons.email,
    },
    {
      'name': 'Create Account',
      'route': Routes.CREATE_ACCOUNT,
      'icon': Icons.person_add,
    },
    {
      'name': 'Verify Code',
      'route': Routes.VERIFY_CODE,
      'icon': Icons.verified_user,
    },
    {'name': 'Location', 'route': Routes.LOCATION, 'icon': Icons.location_on},
    {'name': 'Location QR', 'route': Routes.LOCATION_QR, 'icon': Icons.qr_code},
    {
      'name': 'Location Manual',
      'route': Routes.LOCATION_MANUAL,
      'icon': Icons.edit_location,
    },
    {
      'name': 'Restaurants',
      'route': Routes.RESTAURANTS,
      'icon': Icons.restaurant,
    },
    {
      'name': 'Virtual Assistant',
      'route': Routes.VIRTUAL_ASSISTANT,
      'icon': Icons.support_agent,
    },
    {'name': 'Menu', 'route': Routes.MENU, 'icon': Icons.menu_book},
    {
      'name': 'Food Detail',
      'route': Routes.FOOD_DETAIL,
      'icon': Icons.fastfood,
    },
    {
      'name': 'Recommendation',
      'route': Routes.RECOMMENDATION,
      'icon': Icons.thumb_up,
    },
    {'name': 'Rewards', 'route': Routes.REWARDS, 'icon': Icons.card_giftcard},
    {'name': 'Cart', 'route': Routes.CART, 'icon': Icons.shopping_cart},
    {
      'name': 'Order Status',
      'route': Routes.ORDER_STATUS,
      'icon': Icons.delivery_dining,
    },
    {'name': 'Checkout', 'route': Routes.CHECKOUT, 'icon': Icons.payment},
    {'name': 'Add Card', 'route': Routes.ADD_CARD, 'icon': Icons.credit_card},
    {
      'name': 'Payment Success',
      'route': Routes.PAYMENT_SUCCESS,
      'icon': Icons.check_circle,
    },
    {'name': 'Feedback', 'route': Routes.FEEDBACK, 'icon': Icons.rate_review},
  ];

  Future<NavigationService> init() async {
    debugPrint('NavigationService initialized');
    return this;
  }

  Future<dynamic> navigateTo(String route) async {
    try {
      return await Get.toNamed(route);
    } catch (e) {
      debugPrint('Error navigating to $route: $e');
      return null;
    }
  }

  void navigateWithReplacement(String route) {
    try {
      Get.offNamed(route);
    } catch (e) {
      debugPrint('Error navigating to $route: $e');
      _showNavigationError(route);
    }
  }

  void navigateAndRemoveUntil(String route) {
    try {
      Get.offAllNamed(route);
    } catch (e) {
      debugPrint('Error navigating to $route: $e');
      _showNavigationError(route);
    }
  }

  void goBack() {
    if (Get.previousRoute.isNotEmpty) {
      Get.back();
    }
  }

  void showNavigationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: 320,
            height: 500,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Navigation',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Select a screen to navigate to:',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: availableRoutes.length,
                    itemBuilder: (context, index) {
                      final routeInfo = availableRoutes[index];
                      return Card(
                        elevation: 1,
                        margin: EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Icon(
                            routeInfo['icon'] ?? Icons.arrow_forward,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text(
                            routeInfo['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(routeInfo['route']),
                          onTap: () {
                            Navigator.pop(context);
                            navigateWithReplacement(routeInfo['route']);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showNavigationError(String route) {
    Get.snackbar(
      'Navigation Error',
      'Could not navigate to $route',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.7),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
}
