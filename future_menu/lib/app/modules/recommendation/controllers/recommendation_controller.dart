import 'package:get/get.dart';

class RecommendationController extends GetxController {
  final RxList<Map<String, dynamic>> recommendations = <Map<String, dynamic>>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadRecommendations();
  }
  
  void loadRecommendations() {
    // Example data - replace with actual API calls or data service
    recommendations.value = [
      {
        'id': 1,
        'name': 'Margherita Pizza',
        'price': 12.99,
        'rating': 4.7,
        'reviews': 128,
        'image': 'assets/images/food/pizza.jpg',
        'feelings': ['Hungry', 'Comfort food'],
      },
      {
        'id': 2,
        'name': 'Caesar Salad',
        'price': 8.99,
        'rating': 4.5,
        'reviews': 94,
        'image': 'assets/images/food/salad.jpg',
        'feelings': ['Light', 'Healthy'],
      },
      {
        'id': 3,
        'name': 'Beef Burger',
        'price': 14.99,
        'rating': 4.8,
        'reviews': 156,
        'image': 'assets/images/food/burger.jpg',
        'feelings': ['Hungry', 'Craving'],
      },
    ];
  }
  
  void addToCart(Map<String, dynamic> dish) {
    // Implement add to cart functionality
    // This is where you would add the dish to the cart service/controller
    Get.snackbar(
      'Added to Cart',
      '${dish["name"]} has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
} 