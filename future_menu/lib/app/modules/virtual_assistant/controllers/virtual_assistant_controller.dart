import 'package:get/get.dart';
import 'package:future_menu/app/routes/app_pages.dart';

class VirtualAssistantController extends GetxController {
  // Current step in the assistant flow
  final RxInt _currentStep = 0.obs;
  int get currentStep => _currentStep.value;
  set currentStep(int value) => _currentStep.value = value;
  
  // User's selected feelings
  final RxList<String> selectedFeelings = <String>[].obs;
  
  // Restaurant name (can be set dynamically)
  final String restaurantName = 'La Brasserie';
  
  // Available feelings
  final List<Map<String, dynamic>> feelings = [
    {'name': 'Hungry', 'icon': 'assets/icons/hungry.png'},
    {'name': 'Happy', 'icon': 'assets/icons/happy.png'},
    {'name': 'Sad', 'icon': 'assets/icons/sad.png'},
    {'name': 'Stressed', 'icon': 'assets/icons/stressed.png'},
    {'name': 'Tired', 'icon': 'assets/icons/tired.png'},
    {'name': 'Relaxed', 'icon': 'assets/icons/relaxed.png'},
  ];
  
  // Recommendations based on user's selected feelings
  final RxList<Map<String, dynamic>> recommendations = <Map<String, dynamic>>[].obs;
  
  // Sample food data (would come from API in real app)
  final List<Map<String, dynamic>> foodItems = [
    {
      'name': 'Grilled Salmon',
      'price': 22.99,
      'rating': 4.8,
      'reviews': 124,
      'image': 'assets/images/grilled_salmon.jpg',
      'feelings': ['Hungry', 'Healthy', 'Energetic'],
    },
    {
      'name': 'Chocolate Fondant',
      'price': 8.99,
      'rating': 4.9,
      'reviews': 89,
      'image': 'assets/images/chocolate_fondant.jpg',
      'feelings': ['Sad', 'Happy', 'Stressed'],
    },
    {
      'name': 'Caesar Salad',
      'price': 12.50,
      'rating': 4.5,
      'reviews': 76,
      'image': 'assets/images/caesar_salad.jpg',
      'feelings': ['Healthy', 'Light', 'Relaxed'],
    },
    {
      'name': 'Beef Burger',
      'price': 15.99,
      'rating': 4.7,
      'reviews': 102,
      'image': 'assets/images/beef_burger.jpg',
      'feelings': ['Hungry', 'Stressed', 'Tired'],
    },
  ];
  
  // Navigate to menu directly
  void goToMenu() {
    Get.toNamed(Routes.MENU);
  }
  
  // Skip questions and go directly to recommendations
  void skipQuestions() {
    generateRecommendations();
    Get.toNamed(Routes.RECOMMENDATION);
  }
  
  // Go to next step in the assistant flow
  void nextStep() {
    _currentStep.value++;
    
    // If we've completed all steps, go to recommendations
    if (_currentStep.value > 1) {
      generateRecommendations();
      Get.toNamed(Routes.RECOMMENDATION);
    }
  }
  
  // Set step directly to a specific value
  void setStep(int step) {
    _currentStep.value = step;
  }
  
  // Toggle feeling selection
  void toggleFeeling(String feeling) {
    if (selectedFeelings.contains(feeling)) {
      selectedFeelings.remove(feeling);
    } else {
      selectedFeelings.add(feeling);
    }
  }
  
  // Generate recommendations based on selected feelings
  void generateRecommendations() {
    recommendations.clear();
    
    // If no feelings selected, recommend random items
    if (selectedFeelings.isEmpty) {
      recommendations.addAll(foodItems.take(3));
      return;
    }
    
    // Filter items based on feelings
    for (var food in foodItems) {
      List<String> foodFeelings = List<String>.from(food['feelings']);
      
      // Check if any selected feeling matches this food
      for (var feeling in selectedFeelings) {
        if (foodFeelings.contains(feeling)) {
          recommendations.add(food);
          break;
        }
      }
    }
    
    // If no matches found, add default items
    if (recommendations.isEmpty) {
      recommendations.addAll(foodItems.take(2));
    }
  }
  
  // Add item to cart (stub for demonstration)
  void addToCart(Map<String, dynamic> dish) {
    Get.snackbar(
      'Added to Cart',
      '${dish['name']} has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  // Reset the assistant to the welcome screen
  void reset() {
    _currentStep.value = 0;
    selectedFeelings.clear();
  }
} 